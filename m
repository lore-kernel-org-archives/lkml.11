Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F56C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 22:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiGTW2P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 18:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:28:13 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012554BD14;
        Wed, 20 Jul 2022 15:28:12 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id z132so62634iof.0;
        Wed, 20 Jul 2022 15:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4rzQbnpdxz2yFvCxUaYCCAZD5++ab0VAymDUWQTY+nk=;
        b=OozsZYWvnYYXBtTeYwIqUN1kjLv7VAwnKHaxwjq76uvNbI0YBt71q6ad/rqjRua0E8
         rPNf3nw6dgiKfWMbLWECPV9QXwgGZA8p5MQyh83+vJT/5+ZAK91QXMjhTqtbS2Y9+ro2
         J4kpcgPue4lu77Gyc644/wCvaaA7bam3U1LMxzOmyj4TtlUpQor98bJ9BRltI919Jy6k
         nl7LuWxa9DSOlzOQrOA/w8FYESYuLDLXGJnZxFy8dSMBxqcq5TL1wzNscAIBrUniXzLx
         vNmkDhLc4SWkPyJxAEaz9xluDjH/DPP/3aCgMOgZJxzGWso2YyXiuzSopYSnlPR7894l
         iVOQ==
X-Gm-Message-State: AJIora96SvR5LrLG/Y70vY+6dmydVCvQcl72Qc+Frj58bT5JSbFBlhvG
        3fEIINmK4chhsOQQIIUcsw==
X-Google-Smtp-Source: AGRyM1t2IoeCfHfFHtUk+JjKhVpCWmc+jhkhWRB9KKdKZQMSd21CfuqHvyEbuih7zVwbn8Qwn96YdA==
X-Received: by 2002:a05:6602:1355:b0:669:40a5:9c26 with SMTP id i21-20020a056602135500b0066940a59c26mr19336553iov.105.1658356092216;
        Wed, 20 Jul 2022 15:28:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d21-20020a026055000000b0033f1d348b80sm34386jaf.163.2022.07.20.15.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:28:11 -0700 (PDT)
Received: (nullmailer pid 4094609 invoked by uid 1000);
        Wed, 20 Jul 2022 22:28:10 -0000
Date:   Wed, 20 Jul 2022 16:28:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        martin.botka@somainline.org, Rob Herring <robh+dt@kernel.org>,
        jamipkettunen@somainline.org, devicetree@vger.kernel.org,
        marijn.suijten@somainline.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] dt-bindings: power: rpmpd: Add SM6375 power domains
Message-ID: <20220720222810.GA4094558-robh@kernel.org>
References: <20220716193201.455728-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716193201.455728-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 21:32:00 +0200, Konrad Dybcio wrote:
> Add the bindings for SM6375 RPMPDs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.yaml        |  1 +
>  include/dt-bindings/power/qcom-rpmpd.h               | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
