Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6695AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353119AbiCXV5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCXV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:57:20 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FFBB7C76
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:55:47 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2e612af95e3so65328227b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYEqzUc+Pfapc4sMxwo+uOeq6PIucn41FGvHxchecZ0=;
        b=HZps2ZYckW9+s+dZVBppLITFilmdg0uztmxSO6VBxpQelLhSo1kSQvuwmElCAsa/Av
         AzNrT8YOoZ0mPfm+73jfPjtGXVkzaheXaLtAvM17wSG59+XmiDLgrzJPffmb22jKUjdH
         86on4V9maDoznHGbNEpRSHctdMgU0NZb9LCm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYEqzUc+Pfapc4sMxwo+uOeq6PIucn41FGvHxchecZ0=;
        b=1TtCp4w5fzbSGPMu+t/5blrqNu/TCtKIms0/EW8uGQaD3NVyg5e/kVHsh3AQFajOgB
         DuTb9ThX/OnbiNDTA04Hoxa3p2d4YB/QL+0XaOYS9k1KrOOTh9YR6n+Z/cu0mnFQuQpI
         AjKhRpFy0qlppDJThf5JeD6tREt3ZnT2FWepZuvjlj75pTrWsWbEXJLhxt491UTpJlHG
         5JBUME/fXuPTKxRjWKcduSWyK591U8lY4bx1XSqyC6yMK0a4+eptlxhmP9fdtQIygzKu
         UX1SOru/vBeZSMTF8pumm4si6gbgPWJUmJTHvV9SS++rUvL773LHtfWT6asWsQj1tMkw
         yHxg==
X-Gm-Message-State: AOAM5320LBVDv0O7YKn9wrKViLMCEV8g+DSmZJtVtEO/aZaUQBiMjxv2
        Teaz+u6Fd4UdchDPSbN0lxuPgn7EDfoFvUTHGKukhC4VGw==
X-Google-Smtp-Source: ABdhPJxD+GUsGNXibUCwg+DiidjDutjxpfHR4zXGd9TrBGye5hH5lSXva7IIQYzSLvq9G6KqLxNIlJLThsJIySDhokA=
X-Received: by 2002:a81:843:0:b0:2e5:d91d:3e2a with SMTP id
 64-20020a810843000000b002e5d91d3e2amr7212799ywi.443.1648158946375; Thu, 24
 Mar 2022 14:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220324053020.606637-1-apatel@ventanamicro.com>
In-Reply-To: <20220324053020.606637-1-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 24 Mar 2022 14:55:35 -0700
Message-ID: <CAOnJCUKbP5VEXcauvuY29BcbSZ0YXRtjJfNarNyPMN=KGFKXRA@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Enable profiling by default
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:31 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> Let us enable profiling by default in RV32 and RV64 defconfigs so
> that we can use RISC-V PMU drivers on various RISC-V platforms.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
> Changes since v1:
>  - Enable CONFIG_PROFILING instead of CONFIG_PREF_EVENTS in defconfigs
> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index f120fcc43d0a..bfebee46784c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  # CONFIG_SYSFS_SYSCALL is not set
> +CONFIG_PROFILING=y
>  CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 8b56a7f1eb06..2b68b1bd2559 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  # CONFIG_SYSFS_SYSCALL is not set
> +CONFIG_PROFILING=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y
> --
> 2.25.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
