Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68712C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiBXTQi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiBXTQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:16:33 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4222BE87;
        Thu, 24 Feb 2022 11:16:03 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id k2so4377582oia.2;
        Thu, 24 Feb 2022 11:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eNqELIeo3kQiOPExHwPZ/yuxMHEzvBHwvvS2V8FmTjE=;
        b=lIrEP1DGqD7qeoTd5a4zH5OlaWsVUUCWKf0HtHEO5RkhwtLhAhfIXCvV7XwEO/ND6r
         7JtH3ZET3FGaHFHCvlM78lcbWECDKNVm67vv3srtwz24p8hHZMG9GcNBQidRTsN73M4z
         VOpQJTa8sGzSEWbV347O4OXw+tLPArPBMCgquSbP7VRo81MY2iyRWS2i74AtueJ1RXGu
         xTKPN5DOsnK+xeiRuL0cloCfV5F1xyI18hwtt44ntm96ZVwxJXxk8MCDaiahMZZpW8Wx
         FkUFrN8SaB8U36x0cqW1RbjsE25wfIXnVmLc3R6A49LE/tXBN7VcCvx2cvFM0jKMzZH0
         GG8Q==
X-Gm-Message-State: AOAM533dXebTono83qtItUXB8YQezKOyIZ2NAJgluiSovCtbjB2TJNll
        KpHnJ9GK9Y4lOI+fkrt5GA==
X-Google-Smtp-Source: ABdhPJzNIJyHnETk68d2r5c75FWEjRSxQzBWx3p/rhNFIkbFHZhoLBEskEofCBuci2z6sQ7H7wRDPw==
X-Received: by 2002:a05:6808:1792:b0:2d4:17e8:b58f with SMTP id bg18-20020a056808179200b002d417e8b58fmr8345235oib.158.1645730162585;
        Thu, 24 Feb 2022 11:16:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 126-20020aca0684000000b002d417464153sm191671oig.4.2022.02.24.11.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:16:01 -0800 (PST)
Received: (nullmailer pid 3428386 invoked by uid 1000);
        Thu, 24 Feb 2022 19:16:00 -0000
Date:   Thu, 24 Feb 2022 13:16:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, sboyd@kernel.org,
        robh+dt@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: clock: Add A7 PLL binding for SDX65
Message-ID: <YhfZcJEmHq432DX4@robh.at.kernel.org>
References: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com>
 <1645505785-2271-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645505785-2271-2-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 10:26:21 +0530, Rohit Agarwal wrote:
> Add information for Cortex A7 PLL clock in Qualcomm
> platform SDX65.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,a7pll.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
