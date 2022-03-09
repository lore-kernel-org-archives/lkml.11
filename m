Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 10:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiCIKD7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 05:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiCIKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:03:53 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B381710B9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:02:45 -0800 (PST)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQ6C0-1nnnj133YW-00M5Yh for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022
 11:02:43 +0100
Received: by mail-wr1-f54.google.com with SMTP id p9so2121542wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 02:02:43 -0800 (PST)
X-Gm-Message-State: AOAM531QGw3veECBOMNhPFoyInnV7ua6/opyg9HTeb9fyyrdP1q2wTiz
        7NPdXr33rzJPahlfSVUl3XWhXBJOSQLKMiK26YI=
X-Google-Smtp-Source: ABdhPJwgkE8297GnOt7TTEbR/TrVC0SZLwL1B0Ochv9s5Yu6J38a4vXCAEDpRuE4kakjuYoCPOko8LRH1gaACfFyprU=
X-Received: by 2002:a5d:6810:0:b0:203:7cbb:20be with SMTP id
 w16-20020a5d6810000000b002037cbb20bemr711554wru.219.1646820163359; Wed, 09
 Mar 2022 02:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20220309052842.247031-1-michael@michaelkloos.com>
In-Reply-To: <20220309052842.247031-1-michael@michaelkloos.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Mar 2022 11:02:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Mr_z6h7eg1O8ZN5_qE-o+8KFFBum3CxyuDYeF50s1dw@mail.gmail.com>
Message-ID: <CAK8P3a2Mr_z6h7eg1O8ZN5_qE-o+8KFFBum3CxyuDYeF50s1dw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the M-extension
To:     "Michael T. Kloos" <michael@michaelkloos.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eUPeBs8nu9lonOVUtsH3evuG9vL6qAzG37iPHHX+3lkuvoR6dPe
 z2MH0YfiG8Uovt6yTmDCI8UY+zCCy0FR4FFrBUTr6MOpu49cLY0xWeqvrX6hK98HKkoY9f1
 HW430hjtJcPzPxplPd/W5B8rPhlBpAV2W4bxRfJ6qr+i5ZJMVIwDYHBCg4XuHjiF4bIS68T
 6rCKCWOYCKQU/9PXcre7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cxkPjTEjR9U=:y3p+S67eYq+cn6t7T7Dd5S
 qbVoq3utFoCbv92MHn+DApvHeS4LDHoRJRXQfrqjoFFER8FNkzBMIw+iqzN1FWbKERtqQqN0r
 LZ1fhmosSd/9BAZbivNk73E4Nd7GGg/tY8yGMAYRb4M05Wk3u4/q2JUBYBxdNt5jXv15bAH7k
 LWVpxsK524Ihj1RqRTQZOKWcu9R13ZldhdgbCTNBBm4RPoCTI7EY/FL6rR9q1lwLXBnyy2O/l
 1PiwFAJHfqR73i5GBILTQvID+LleJQmnKUZeM9lmRUEvk4KNt7JdGNqvewI6fT2J0JIJ2MmT6
 HHsAgfzX0RXQdsRTMxxpMsOagyYc+4yOujrI0bD2axKgyZXRdJh1x0q/+zAaO5SZIZl+6pCDo
 zX6t1mB08jChejjzFSr/naRqSuPb+KrJpJmmWBRTg6eQ/srzpgK02yETk/w53cFBNc7QhEwHI
 sdHu5oI410ephnbZOwQPzmmADKrCbQOIl/a3g9psjKF/zREQHOrR5YiDhkWLf3JLPiE+mqKST
 LGjLBAqMusbiQbSX29zz9zab/22T3cKs+PW0hyrdebueCTuVAm1gaV6bdBK1AvkLWU3CtZTcK
 WU63gtRcGOujRfNYYTbwsAtOvgDEwxZKYnHT2OvyBLbdMGM5DcuU2UnihtQJhqHlCN++We91w
 kz/zEDQtzOHohBNCpgy4BZBWPsjDzyvyw7vkliwdnr0o+BZUcAaNRJo/kBpXmedwdM5A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 6:28 AM Michael T. Kloos
<michael@michaelkloos.com> wrote:
>
> Added a new config symbol RISCV_ISA_M to enable the usage of the
> multiplication, division, and remainder (modulus) instructions
> from the M-extension.  This configures the march build flag to
> either include or omit it.
>
> I didn't find any assembly using any of the instructions from
> the M-extension.  However, the BPF JIT is a complicating factor.
> Currently, it emits M-extension instructions to implement various
> BPF operations.  For now, I have made HAVE_EBPF_JIT depend on
> CONFIG_RISCV_ISA_M.
>
> I have added the supplementary integer arithmetic functions in
> the file "arch/riscv/lib/ext_m_supplement.c".  All the code
> contained in this file is wrapped in an ifndef contingent on the
> presence of CONFIG_RISCV_ISA_M.
>
> Signed-off-by: Michael T. Kloos <michael@michaelkloos.com>

The patch looks fine to me, but I increasingly get the feeling that the
entire platform feature selection in Kconfig should be guarded with
a global flag that switches between "fully generic" and "fully custom"
builds, where the generic kernel assumes that all the standard
features (64-bit, C, M, FPU, MMU, UEFI, ...) are present, the
incompatible options (XIP, PHYS_RAM_BASE_FIXED,
CMDLINE_FORCE, BUILTIN_DTB, ...) are force-disabled,
and all optional features (V/B/P/H extensions, custom instructions,
platform specific device drivers, ...) are runtime detected.

At the moment, those three types are listed at the same level,
which gives the impression that they can be freely mixed.

         Arnd
