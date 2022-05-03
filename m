Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FEEC4332F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 00:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiECAL4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 20:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiECALx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 20:11:53 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1662656;
        Mon,  2 May 2022 17:08:21 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id o10-20020a4abe8a000000b0035eac0a004aso2180608oop.11;
        Mon, 02 May 2022 17:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBtpS11zvRC1dD8OgiW23fCfc5oWCL02Wte6MbSC66g=;
        b=XctdhSQuxy/xTFC68NYldIdgM8yveyrj3pWvxzht6mGECej6CHC+YVzDS/VVJbT6As
         ZviAGZ9ptck+/N9bRDqJhn9tDOwvAXQn+u9p9p0N5sXmSVUOVFbxj8PfV8uEGsyuchnd
         tX8mdOqwfPTudjyK3nh8WQe/PVqT8+2BxK4LmbS+66HXVC6Lt+lATi5WaKqJ0/sD40pw
         qGCJCozc75PFMhheDiXjcmPr5mbFa1nQTppTrlF90CwWPC3j5tASWwopyyYD2Kd3ww6o
         ivDWPWs8Z162mWSDkxl7bt9bbW8ZQ6IlilmKUGPCXZy1nT8PWWGxgJAVJ/blg+rC7liu
         12ag==
X-Gm-Message-State: AOAM533oUrprIjGe2XzHxTcfmI1N3KgsaEA1zBulj3vGpIVZq2Unz51e
        KHrGgcVm4DARVwvr3ph3HQ==
X-Google-Smtp-Source: ABdhPJx3YRp7X6HIGqC0rAMJo7nnSbABEm13/DMH9Gp0q/iieeShGF+QH5moxpak2JX792Hb9vI0XQ==
X-Received: by 2002:a4a:b4ca:0:b0:35e:d851:6815 with SMTP id g10-20020a4ab4ca000000b0035ed8516815mr4127606ooo.65.1651536500791;
        Mon, 02 May 2022 17:08:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c20-20020a05687093d400b000e686d13898sm6433326oal.50.2022.05.02.17.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 17:08:20 -0700 (PDT)
Received: (nullmailer pid 2073081 invoked by uid 1000);
        Tue, 03 May 2022 00:08:19 -0000
Date:   Mon, 2 May 2022 19:08:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: mailbox: qcom-ipcc: add missing
 compatible for SM8450
Message-ID: <YnByc6RtYLzAgP4i@robh.at.kernel.org>
References: <20220426101837.16201-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101837.16201-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 12:18:36 +0200, David Heidelberg wrote:
> Fill missing compatible already used in SM8450 DTS.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
