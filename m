Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 22:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351461AbiC3WNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiC3WNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:13:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4A220ED
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D82146178B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4196DC340EE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648678322;
        bh=lHoWMWTBa3YM4ZDyXUSfiun+4hg+TkgrQeAvpXnV8dM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G+4D0E+N2X4RZG7RuopLwUDRZ5fmnXbKKxlhE4xjxQ/w0V6nsaT2S5OilUzmgwDuY
         elIksuIWAexVfxRqDRV/L76hI6IECqlxXGPRNIM1SPH1YdKlwFN76MuW0X2j20dTUs
         f2oRVK8ygsp50zLXE9W7kVnVUs/2NxrOzpmJqe5tswh5yOcsZwJfAF0mnDtWSI5w/J
         U/+hUJuxgTeaQDc7z4Wu3JjwtJ4fMO2AYLXgECSV9OmFz0AreBYV1/iqKtcu0QXzNu
         F9CKdRVvvR6tXmSlsSKeGiOkKle2kETuRXleERZLxHn8T5Lao3r8TVsAVxYE4my0pT
         NwuiXDyS1PaDg==
Received: by mail-io1-f48.google.com with SMTP id p21so12535117ioj.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:12:02 -0700 (PDT)
X-Gm-Message-State: AOAM532dUq/XNztQwjGvepfp5rKwX0VuxF/5QMeIuRmT/PdlVtquBXtI
        LFfPEhIjxhmIo0/7zs1gRs7XRQqZ7HuWDDPyRQ==
X-Google-Smtp-Source: ABdhPJwz1I8224QmKi3GJkG495gJ+jibhVHp8fiJgqcR/6al4HLKY11f5Vyz0kFI8Ep0x3RH7WAuWz3ynmlArVoGYjU=
X-Received: by 2002:a05:6638:3052:b0:317:79e1:8b7f with SMTP id
 u18-20020a056638305200b0031779e18b7fmr1180334jak.239.1648678321433; Wed, 30
 Mar 2022 15:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com> <20220311101940.3403607-4-tarumizu.kohei@fujitsu.com>
In-Reply-To: <20220311101940.3403607-4-tarumizu.kohei@fujitsu.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 30 Mar 2022 17:11:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLfDQid2WFDnFDp237wQ+hAx=0g=rumYWWpdJ=aoGf5MA@mail.gmail.com>
Message-ID: <CAL_JsqLfDQid2WFDnFDp237wQ+hAx=0g=rumYWWpdJ=aoGf5MA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] arm64: Add hardware prefetch control support for ARM64
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 4:23 AM Kohei Tarumizu
<tarumizu.kohei@fujitsu.com> wrote:
>
> This adds module init/exit code, and creates sysfs attribute files for
> "stream_detect_prefetcher_enable", "stream_detect_prefetcher_strong"
> and "stream_detect_prefetcher_dist". This driver works only if part
> number is FUJITSU_CPU_PART_A64FX at this point. The details of the
> registers to be read and written in this patch are described below.
>
> "https://github.com/fujitsu/A64FX/tree/master/doc/"
>     A64FX_Specification_HPC_Extension_v1_EN.pdf
>
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---
>  arch/arm64/kernel/pfctl.c | 368 ++++++++++++++++++++++++++++++++++++++

This has nothing to do with arm64 arch other than you access registers
as sysregs. That's not enough of a reason to put in arch/arm64. Move
this to drivers/ assuming it continues. I agree that this seems
questionable to expose to userspace in the first place...

Rob
