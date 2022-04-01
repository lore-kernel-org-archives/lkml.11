Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFF8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350950AbiDATwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiDATwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:52:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53C91C2325;
        Fri,  1 Apr 2022 12:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ECFA616EC;
        Fri,  1 Apr 2022 19:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA29C2BBE4;
        Fri,  1 Apr 2022 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648842651;
        bh=PKTFHbSH2UMkep2LxR08v4Qo2oXbGIPuL7oyn0ZenWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WPKKYPjYyDTLLAm+QGrpTCsUY9xUETEer9nSxBTmhQirlDQ1PO0aMTd00lI5ixras
         yOZ79hHPzYBSHRQWDgIWOJKN3RLNQ+qlY9Ia1H/QJ40c0nTSHm7QBy+EhAtgwdllO+
         sAEvhxO7J6dOu647JvRG4j5G1SSkRQsmg5rxS8xiDh9h5yzcPEAQxWsV7nbke6in+R
         J42ZV1loDbwntr24GpIKKro5/bdXxWjehJxGYSM5mBDqPO9hdU0Mo62L4+K0q5zaby
         ryco0KJa4J66fbCMYUS3lA43kUiseRK0qLsmKkur8Fdm8p/q08nZ3Y0tTWvKtDCCVr
         hsCPVLWFhCdXg==
Received: by mail-io1-f42.google.com with SMTP id q11so4414911iod.6;
        Fri, 01 Apr 2022 12:50:51 -0700 (PDT)
X-Gm-Message-State: AOAM531Bzvt8xTsMj/mabgy+tXt8EG5VSfeEwbPPGGpXi4oTqKF54YeH
        Y62O46s1Z9vNo4Q6u+IqGH1XYQKn3m9w+5kQGA==
X-Google-Smtp-Source: ABdhPJyIcUK7bqTW8w5TQkOlzL6lG73KMke4wGGd5zyAjhua+Xd9s8cC/DO2J5ZOXZGS9IfXEI2/dDTCAlNA8o40WWE=
X-Received: by 2002:a05:6638:3052:b0:317:79e1:8b7f with SMTP id
 u18-20020a056638305200b0031779e18b7fmr6364291jak.239.1648842650947; Fri, 01
 Apr 2022 12:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220401193108.12490-1-palmer@rivosinc.com>
In-Reply-To: <20220401193108.12490-1-palmer@rivosinc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Apr 2022 14:50:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ALvAUR5V4Fv1RohA=-PB0Ry05ETm6OqJ+f=ediGc7HA@mail.gmail.com>
Message-ID: <CAL_Jsq+ALvAUR5V4Fv1RohA=-PB0Ry05ETm6OqJ+f=ediGc7HA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix phandle-array issues in the idle-states bindings
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 2:32 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> As per 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas"), the
> phandle-array bindings have been disambiguated.  This fixes the new
> generic idle-states bindings to comply with the schema.
>
> Fixes: 1bd524f7e8d8 ("dt-bindings: Add common bindings for ARM and RISC-V idle states")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  .../devicetree/bindings/cpu/idle-states.yaml  | 96 +++++++++----------
>  1 file changed, 48 insertions(+), 48 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
> index 95506ffb816c..6f5223659950 100644
> --- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
> +++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
> @@ -385,8 +385,8 @@ examples:
>              compatible = "arm,cortex-a57";
>              reg = <0x0 0x0>;
>              enable-method = "psci";
> -            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
> -                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
> +            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
> +                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;

All the Arm examples are already fixed. You need to fix just the RiscV
examples added in your branch. Otherwise, it is a bunch of merge
conflicts.

Rob
