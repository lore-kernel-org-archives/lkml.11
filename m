Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D202C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 15:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbiGSPYt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiGSPYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:24:47 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D7656B80
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:24:45 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id l3so9262378qkl.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HV4Wgjz/TAUUMEiA/dyksbNxySCx+zbsJF2fZfi2554=;
        b=gmf4YGqjemuHOT8ZL/Bp1Mg52WRVpVhGxdGFTRmncYgDpwg1aHZU3ugM3y3Lb/I6Vk
         02ggbPvAwlXO/4+fuHOrDGrbFipslgUYPeLUxEZVE9ww5tiF9BeEUVRPb1wlbYuAf5Lq
         +Y5IK1PcsmXOWzQWjPqmoAIB+JXmPdZT/op/JNEKn2kR8yEsmLlSXfAw6BihZI8wp3PO
         ps9FVe//nMJQ6EOSih7QXXxEyhezudOQl7OI4uwEqKudNAp+Yp+Lbgg8LlkehSWY7HS9
         K7sSyVaQps4KchtmUD4xvl19f9clvnbHg7Mu3zx0dWRvXeSlyUIiXNFXsX/xkHpu/kiq
         cKdg==
X-Gm-Message-State: AJIora8RAwHii3t4iXVZJTSc9OGsddqxaCM+N3FAdaHWlifTD1VHLJAf
        oYOihMTN/b4Z4enLYe5IuAGdsFSE6gYBhg==
X-Google-Smtp-Source: AGRyM1uuj7r8N19QcmfVLpX4dGqjJCxyrLOAQq6h6onh9qNjcxEBdNKxtx0+0APmom2Jwp+2rwVTKg==
X-Received: by 2002:a05:620a:4452:b0:6b2:4f49:d053 with SMTP id w18-20020a05620a445200b006b24f49d053mr19981340qkp.685.1658244284652;
        Tue, 19 Jul 2022 08:24:44 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l5-20020a37f905000000b006b56a4400f6sm13535861qkj.16.2022.07.19.08.24.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:24:44 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id c131so26364739ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:24:44 -0700 (PDT)
X-Received: by 2002:a25:bc8e:0:b0:66e:fe43:645c with SMTP id
 e14-20020a25bc8e000000b0066efe43645cmr32967226ybk.202.1658244283883; Tue, 19
 Jul 2022 08:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220715102609.2160689-1-sudeep.holla@arm.com> <20220715102609.2160689-2-sudeep.holla@arm.com>
In-Reply-To: <20220715102609.2160689-2-sudeep.holla@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 17:24:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVfr3kzdacSJkPaOZ56x+7tJ1MjrUz+VG+Y+8aL+XW+jg@mail.gmail.com>
Message-ID: <CAMuHMdVfr3kzdacSJkPaOZ56x+7tJ1MjrUz+VG+Y+8aL+XW+jg@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/2] arch_topology: Fix cache attributes
 detection in the CPU hotplug path
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Fri, Jul 15, 2022 at 12:28 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> init_cpu_topology() is called only once at the boot and all the cache
> attributes are detected early for all the possible CPUs. However when
> the CPUs are hotplugged out, the cacheinfo gets removed. While the
> attributes are added back when the CPUs are hotplugged back in as part
> of CPU hotplug state machine, it ends up called quite late after the
> update_siblings_masks() are called in the secondary_start_kernel()
> resulting in wrong llc_sibling_masks.
>
> Move the call to detect_cache_attributes() inside update_siblings_masks()
> to ensure the cacheinfo is updated before the LLC sibling masks are
> updated. This will fix the incorrect LLC sibling masks generated when
> the CPUs are hotplugged out and hotplugged back in again.
>
> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> v1->v2:
>         - No change in this patch, but 1/2 was added to fix possible
>           bug "sleeping in the atomic context" with this patch.
>         - Added all the received tags

Thank you, the "Early cacheinfo failed, ret = -12" is gone.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
