Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33EDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 10:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiF0K4J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiF0K4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECEA646F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA9C161261
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F39C3411D;
        Mon, 27 Jun 2022 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656327366;
        bh=ZP/cwDpw3phVOoc86jYL1gb83zZ+27HL+h+osgRcvO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H55EG3Z5qpRg+niCkCAbsdjZljaH5i0Iys3jHRIkS4UZihJGTv12Ow5HF2f/trV31
         0vmtg84VUwiFAOt7OJeFogL9fl1yEdv7JRNIBoOJEjKK909iswwYnuxEzPG9iYZLEH
         GpV2fqXymoh3TN6h8MzsjE5zCO4NZzSjN8rUoG3CpshgRxC9SvLnVrzFd+X+PJW0ad
         D6Go4Uzfyqsfcx02kIkIAgkGrBQIlh9G05f9QlzNBIgcr6MRZU8BJwGXvPzffAl6yW
         8cPWtUO3UG9TkJ5RfVlUKCnVnY6FOcmPHxO4eBVIpSG0lC2D2c45ScnY3mUispQCNr
         dr0bsMA3iFWxg==
Date:   Mon, 27 Jun 2022 11:56:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        =?iso-8859-1?Q?Jo=E3o_M=E1rio?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] drivers/perf: riscv_pmu_sbi: perf format
Message-ID: <20220627105559.GE22095@willie-the-truck>
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
 <20220624160117.3206-2-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624160117.3206-2-nikita.shubin@maquefel.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 07:00:51PM +0300, Nikita Shubin wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> Update driver to export formatting and event information to sysfs so it
> can be used by the perf user space tools with the syntaxes:
> 
> perf stat -e cpu/event=0x05
> perf stat -e cpu/event=0x05,firmware=0x1/
> 
> 63-bit is used to distinguish hardware events from firmware. Firmware
> events are defined by "RISC-V Supervisor Binary Interface
> Specification".
> 
> perf stat -e cpu/event=0x05,firmware=0x1/
> 
> is equivalent to
> 
> perf stat -e r8000000000000005
> 
> Inspired-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> ---
>  drivers/perf/riscv_pmu_sbi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index dca3537a8dcc..2b5861a10d8e 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -21,6 +21,25 @@
>  #include <asm/sbi.h>
>  #include <asm/hwcap.h>
>  
> +PMU_FORMAT_ATTR(event, "config:0-62");
> +PMU_FORMAT_ATTR(firmware, "config:63-63");

Usually single-bit fields omit the upper bound, so this would be simply
"config:63".

Will
