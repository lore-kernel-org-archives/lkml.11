Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbiCWSjy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiCWSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:39:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA961E3F5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:38:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r22so4612182ejs.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JsH2SIUTrsYJX8zmjcQSu5hxXE5Ybek62ru5rVjSD7A=;
        b=eZkOyr5ipSOEyIaKi0RWFAaNJ6zbGXp8L0jzeF10aH5B4vhrsB9UpLMn7mQmn+dQn5
         wMkGvPw+1qRPsVxG/Ug6yNmt5/Kepqq3YzzD0RVmt3KPRryxnF0eE6qx6PaQfy3P3n0u
         8WT2X7IgjBlZG112zAKt1B96P4bbzh/u7jBUUIIrC5Wi9Ft23Us/+XHbQGgf6lxb0BCP
         yTqX5wfdvLCBEDKTdGpCT1T85ke+il9XVbUENQHF2kBATRBpOjAMfX6dg70jbIpq9Gps
         wTDzqVolirKFCPH5CLgnzfW/YBzltdd3pS4jviyozQhjcthcAF/nNnOhWlxsJRMm7WDj
         C8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JsH2SIUTrsYJX8zmjcQSu5hxXE5Ybek62ru5rVjSD7A=;
        b=TVQwzw7n7hbd5wWpLQLcYfhK041nkTblNhYtAeE9wIkhVRO7pft8qhZxFbNEJaQiAC
         KDZbzDDUaO/58wEN5XOsm2TsJm/rAD5nvJDkMou5bQPrbjUayrbKvZ2Ontuc+fBarlDW
         NV5dgBo/V3bO/OAQQlayy9Becxt1u7Dyze1PddO5IPv/HVVChurAwFaNKlNJOmYGp1q1
         i+BQ6UmlR4FjEie3un9+YGZQ45biUTxm9ybSLRgGGly0UgZFH3Mmd07rQmqPa3uDgiqq
         HCFC3GM239Riyrcw7ilQ3qgvmzpMi8h160waB2i7yKiQowftEmVfgHYiAyNFJXBKqTEg
         cX7g==
X-Gm-Message-State: AOAM5320KPo2lxzVVY/anNk37p4aYJnU2kB8poa6CoRfnncXuTmVx4eV
        X3sae6G7QrOiaXFwfow1mULMy4DtyaNGKrejaKuU7A==
X-Google-Smtp-Source: ABdhPJyBBF/hTWA2LGiY86ag+BZL5f9TnZ6rcxh1EVMGytKL9CE/oPbM43JdHk6KoChnnPqBvP/t5NTH6fzCJauVAG4=
X-Received: by 2002:a17:907:9602:b0:6df:e82c:f84 with SMTP id
 gb2-20020a170907960200b006dfe82c0f84mr1587691ejc.590.1648060691197; Wed, 23
 Mar 2022 11:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220322144447.3563146-1-tongtiangen@huawei.com> <20220322144447.3563146-5-tongtiangen@huawei.com>
In-Reply-To: <20220322144447.3563146-5-tongtiangen@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 23 Mar 2022 14:37:34 -0400
Message-ID: <CA+CK2bAUKB0SM3dBM0WauGp1WVKVzouQwOy8Z+a4CD38TZctpQ@mail.gmail.com>
Subject: Re: [PATCH -next v2 4/4] riscv: mm: add support for page table check
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:26 AM Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
> check"), add some necessary page table check hooks into routines that
> modify user page tables.
>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha
