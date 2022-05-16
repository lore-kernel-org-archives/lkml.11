Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AFEC43217
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 22:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbiEPW4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 18:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349826AbiEPW4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:56:02 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7680865BB;
        Mon, 16 May 2022 15:55:59 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f16a3e0529so11831678fac.2;
        Mon, 16 May 2022 15:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WWIkYq2gmKsjJ10G1579jbzJ51SdBFfwyh8O5uRzmK0=;
        b=c3iKe5OXPkqJWM4NbtdXUvjqgyzcNdcIkB5SPCp/irJ1Tqt8PdHHLiAoBaOCoP9cSE
         BaORZ0q97TgdOBkNYpqkzYoIetRUGThauilZFowhDPiFg1+0ovIefL1rKWEhw68D2JgP
         ikmUKFpdWQXNm8ZSUVXGmX1yzFW754tzFB6BUsvDF2NYy4tx++bUyyIlAN0yaHgBqTSC
         zrXHrmz5Ftj1rnp+SLR4gpd7owVXeSqZXUk68a423jj0Na1MA/Vko/KijLZt1LJQBtpa
         JtKHoH1Ny37O18DB8IJaeIDvm21ksi+dRZlcHEikJgihAbj6DiGEmX9sTtQYANX5szLt
         17MA==
X-Gm-Message-State: AOAM533ZHKVUjVp4DC+5hcj9Pa1dQokdCnr6lyeQ9fFzRr+L6MpWYbdb
        tPLIExIpe0MyNUawP9gZwg==
X-Google-Smtp-Source: ABdhPJwk3pQZyl//Mn32sjbmvYJ11kR4v8NtTekdMFosCVDqdVv8PAXebaB3Di53dAeOJFllXSwflA==
X-Received: by 2002:a05:6870:2189:b0:ed:995f:8f1 with SMTP id l9-20020a056870218900b000ed995f08f1mr10428874oae.33.1652741758724;
        Mon, 16 May 2022 15:55:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t14-20020a056870f20e00b000f15a771206sm5406648oao.36.2022.05.16.15.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:55:57 -0700 (PDT)
Received: (nullmailer pid 3473100 invoked by uid 1000);
        Mon, 16 May 2022 22:55:57 -0000
Date:   Mon, 16 May 2022 17:55:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     f.fainelli@gmail.com, daniel.lezcano@linaro.org,
        Rob Herring <robh+dt@kernel.org>, sudeep.holla@arm.com,
        vincent.guittot@linaro.org, james.quinlan@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        souvik.chakravarty@arm.com, adrian.slatineanu@arm.com,
        devicetree@vger.kernel.org, tarek.el-sherbiny@arm.com,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH 1/7] dt-bindings: firmware: arm,scmi: Add powercap
 protocol
Message-ID: <20220516225557.GA3473042-robh@kernel.org>
References: <20220504093609.3077646-1-cristian.marussi@arm.com>
 <20220504093609.3077646-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504093609.3077646-2-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 May 2022 10:36:03 +0100, Cristian Marussi wrote:
> Add new SCMIv3.1 Powercap protocol bindings definitions and example.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
