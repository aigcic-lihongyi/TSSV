// import library
import { Module, type TSSVParameters, type IntRange } from 'tssv/lib/core/TSSV'
import { writeFileSync } from 'fs'

export interface round_Parameters extends TSSVParameters {
  data_in_Width?: IntRange<1, 256>
  data_out_Width?: IntRange<1, 256>
}

export class round extends Module {
  declare params: round_Parameters
  constructor (params: round_Parameters) {
    super({
      // define the default parameter values
      name: params.name,
      data_in_Width: params.data_Width || 16,
      data_out_Width: params.data_Width || 12
    })
    // define IO signals
    this.IOs = {
      data_in_signed: { direction: 'input', type: 'wire', width: this.params.data_in_Width, isSigned: true },
      data_in_unsigned: { direction: 'input', type: 'wire', width: this.params.data_in_Width, isSigned: false },
      data_out: { direction: 'output', type: 'wire', width: this.params.data_out_Width, isSigned: true }
    }

    const rShift = Number(this.params.data_in_Width) - Number(this.params.data_out_Width)
    this.addSignal('roundUp_signed', { width: this.params.data_out_Width, isSigned: true })
    this.addSignal('roundDown_signed', { width: this.params.data_out_Width, isSigned: true })
    this.addSignal('roundUp_unsigned', { width: this.params.data_out_Width, isSigned: false })
    this.addSignal('roundDown_unsigned', { width: this.params.data_out_Width, isSigned: false })
    this.addSignal('roundZero', { width: this.params.data_out_Width, isSigned: true })
    this.addSignal('roundEven', { width: this.params.data_out_Width, isSigned: true })
    this.addRound({ in: 'data_in_signed', out: 'roundUp_signed', rShift }, 'roundUp')
    this.addRound({ in: 'data_in_signed', out: 'roundDown_signed', rShift }, 'roundDown')
    this.addRound({ in: 'data_in_unsigned', out: 'roundUp_unsigned', rShift }, 'roundUp')
    this.addRound({ in: 'data_in_unsigned', out: 'roundDown_unsigned', rShift }, 'roundDown')
    this.addRound({ in: 'data_in_signed', out: 'roundZero', rShift }, 'roundToZero')
    this.addRound({ in: 'data_in_signed', out: 'roundEven', rShift }, 'roundToEven')
  }
}

// ============================================test=======================================================
console.log('test1')
const test_round = new round({ data_in_Width: 16, data_out_Width: 12 })
try {
  writeFileSync(`sv-examples/test_round_output/${test_round.name}.sv`, test_round.writeSystemVerilog())
} catch (err) {
  console.error(err)
}
