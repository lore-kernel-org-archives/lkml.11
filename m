Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C41CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 23:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiGKXI7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 19:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiGKXIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:08:52 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16022DF85;
        Mon, 11 Jul 2022 16:08:47 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id r76so6340416iod.10;
        Mon, 11 Jul 2022 16:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VseoR+eOx4Z3QoDDCGx90Kg7pcCHtGEXvwLjBriYeCU=;
        b=D+Ia8FIxCFzbyQ6fPymySRenbLW/QW1KI8ng38FUx08+qjDsGRYYDTNQd6qFvYcgED
         wrsF25yuegSD0nnuTfEVPUK+HwJOP79QeldxrgsjukRXDbBQSMITkO9eO8EQvso/mljJ
         TTyfqLssVbd+7rkFHG2drKhHxo/6jK9WOtKH21LhXUngcuT7mrRqwWU5qaQ/pyynnv0y
         mMgSwVMBX0t1P7KMIkZqkTKzmGcw1/PQQk2OOFr8esyKULovfMnQgGGwB+ewGfAAi1Uc
         CyGkC0hG+Ie5y+fHKRnfnoEa3uE2MLJHdTT4T+7yhJzYXksxKerW2ceiQ3i/g6xAHCy+
         JHlg==
X-Gm-Message-State: AJIora8z6fcx+W18fp/hYINcsVocLYXw06QhWbmk8JvzW3E0x5Mepzz5
        /YhDfYfUFnSK5moHs2G5qA==
X-Google-Smtp-Source: AGRyM1uS4ISjJtPUznxV08Hdiqtmg0DIKreCE1miOboWMCmLhSydoQLNwHgWWtVWe68jDGaWIC03Og==
X-Received: by 2002:a02:aa1a:0:b0:331:9183:9136 with SMTP id r26-20020a02aa1a000000b0033191839136mr11465189jam.242.1657580926633;
        Mon, 11 Jul 2022 16:08:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f1-20020a926a01000000b002dc0d743570sm3114643ilc.43.2022.07.11.16.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:08:46 -0700 (PDT)
Received: (nullmailer pid 442016 invoked by uid 1000);
        Mon, 11 Jul 2022 23:08:45 -0000
Date:   Mon, 11 Jul 2022 17:08:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Yan <andyshrk@163.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add OPEN AI LAB
Message-ID: <20220711230845.GA441965-robh@kernel.org>
References: <20220709102902.2753851-1-andyshrk@163.com>
 <20220709102942.2753939-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709102942.2753939-1-andyshrk@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jul 2022 18:29:42 +0800, Andy Yan wrote:
> Add vendor prefixes for OPEN AI LAB.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> 
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
