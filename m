Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC05C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 16:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiGAQRx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiGAQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:17:50 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00463F33E;
        Fri,  1 Jul 2022 09:17:49 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id r133so2738265iod.3;
        Fri, 01 Jul 2022 09:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3p39DaXpEIKe1IC6DHEHYoK53aXZYytzVNsyvr74DA=;
        b=IXCAUzPyOtDWxTN+1CtFc9WYVLYp/08f8N0aHLhx4r/i+++ZgxMU/uP8wTnfmCnSBw
         eIuW63t2+NAROi3Mf76cfLGCpOXtRSNIF6Kpi6Kmtx9xBlI/6ZKIeeqL1HBRgEgc4Yvd
         WpmEPNLGES5cHWkpRp1ikjQgmG6gDEdXUmXJNk2R7pK9/Urf0lZQjCvC4RTa8A6OXFQI
         3wIsstRvDxnuvr6f4g3ACnv4BBfFIVl1mOhYQVG/xbozb+ga60feUTlF6QqCHiDGJrZg
         8z0VvQBLhmBPQDqYc1assaMNv6tckm86a2XNjGJLRAew+kUVDV9A/Cw02R3ZCcmEb4nE
         Xbow==
X-Gm-Message-State: AJIora/dRgxjOGm3HlnX+p+5R8Gvyj4oJssoY5brqwu4DVNxLXGSBnQd
        X7gGk+n8SJ4XQerXEsPIqg==
X-Google-Smtp-Source: AGRyM1sPR/ejKgtkX1GxIw8ni/Rd20wFIAFtoYqJIUY82FA9zqLPBfWJOqjFr4WONWMnyPqsoQimwA==
X-Received: by 2002:a6b:7012:0:b0:675:43e5:58a1 with SMTP id l18-20020a6b7012000000b0067543e558a1mr8041018ioc.4.1656692268948;
        Fri, 01 Jul 2022 09:17:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t9-20020a056e02010900b002d928e265ffsm6182761ilm.81.2022.07.01.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:17:48 -0700 (PDT)
Received: (nullmailer pid 1064062 invoked by uid 1000);
        Fri, 01 Jul 2022 16:17:46 -0000
Date:   Fri, 1 Jul 2022 10:17:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     vkoul@kernel.org, vigneshr@ti.com, linux-phy@lists.infradead.org,
        sjakhade@cadence.com, kishon@ti.com, linux-kernel@vger.kernel.org,
        t-patil@ti.com, s-vadapalli@ti.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: phy: Add PHY_TYPE_USXGMII definition
Message-ID: <20220701161746.GA1064001-robh@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
 <20220628122255.24265-3-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628122255.24265-3-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 15:22:50 +0300, Roger Quadros wrote:
> From: Swapnil Jakhade <sjakhade@cadence.com>
> 
> Add definition for USXGMII phy type.
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  include/dt-bindings/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
