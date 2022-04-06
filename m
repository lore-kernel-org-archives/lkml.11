Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC8FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 20:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiDFUZ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiDFUVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:21:50 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EC15729;
        Wed,  6 Apr 2022 11:16:20 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-df02f7e2c9so3786001fac.10;
        Wed, 06 Apr 2022 11:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3DcT65QQ0fFX6erprizuCZP9AN2bBYzGsaDxgJE1Qq4=;
        b=QVWCCS6Ketuz2O8wNpKzQ7yl57abhLAP3jUbF/BhOVPidXydhHzDr5glGtjNg51pH7
         e6OBfoWCCM1UAuEIe7ADCSWTdDpTNSrdtlZ0I6xF+jANemtlcdKwLlS7qT8Jam14PO5I
         Wp/yf0xDMc/THjJCy1utyL2CnKL6gzP62TD3BQ8jQvmKWyDBl4yfUyeWkZKEhSdyFX0b
         26URXcvCKdiSf5E9VOoS5FWgh1locIgd7TNfs2PRn8YfloTl/GtRMzgS1Oy+em3miSnb
         VW6sj1iPQtrSP+nI8/SUvXdLcAr/jHtremtiKEl7U57vP7O50JSlgxNSrKM0419a/wFf
         WqWg==
X-Gm-Message-State: AOAM532VT44GcuxTIprr42+aFmXC80hjEdMmND6fEEK9oSyEjIruDiEW
        /1d3feHmZoc+o3u0sftUuQ==
X-Google-Smtp-Source: ABdhPJySTpS1q42dyIrx0Jgd1qd0wepA2b4Cr/SEdFb5jIBG/BglcOxvnDDDtTY+5AXR0qIJmS0heQ==
X-Received: by 2002:a05:6870:5693:b0:e2:1992:14b5 with SMTP id p19-20020a056870569300b000e2199214b5mr4598961oao.131.1649268979861;
        Wed, 06 Apr 2022 11:16:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 65-20020aca0544000000b002f980b50140sm2621141oif.18.2022.04.06.11.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:16:19 -0700 (PDT)
Received: (nullmailer pid 2526475 invoked by uid 1000);
        Wed, 06 Apr 2022 18:16:18 -0000
Date:   Wed, 6 Apr 2022 13:16:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: ave: Clean up clocks, resets, and
 their names using compatible string
Message-ID: <Yk3Y8hQew2/wuUpc@robh.at.kernel.org>
References: <1649145181-30001-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1649145181-30001-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649145181-30001-2-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Apr 2022 16:53:00 +0900, Kunihiko Hayashi wrote:
> Instead of "oneOf:" choices, use "allOf:" and "if:" to define clocks,
> resets, and their names that can be taken by the compatible string.
> 
> The order of clock-names and reset-names doesn't change here.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/net/socionext,uniphier-ave4.yaml | 55 +++++++++++++------
>  1 file changed, 38 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
