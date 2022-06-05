Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE4FC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 22:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348403AbiFEWii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 18:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbiFEWif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:38:35 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B799A2C12F;
        Sun,  5 Jun 2022 15:38:34 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id x16so6054645qtw.12;
        Sun, 05 Jun 2022 15:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2o4Si/ESwdinfrZMz9nTD0LmxXF7OLAHry8I5SkRmG4=;
        b=ijt0QmnS78dPHQE8IYbojVcDJNBQBVSEgVBkxH9/J51mtI4fVcXF+KW51DkiST+jBU
         /7wSiLSsSdbkeDdHEY4ZCgeNj5nqqUKDBlcMz7vvJ1lOBKl+brz3gIy1s7ypKl9JalXs
         rECMmCVyOS7GVE9/ixmiyDyLQ66dzzLFA3/kVurzKJy9/CevCybfCpMd5StJuHEn2nLS
         dC/ShF1BRdaJrsfRMPTIwfzMxoAZG+EF3rv05bLdlNfvqno+FTb0CKsj9TrfSmRqMs12
         bRg1QapUOG81M3By53RLEseDAexmq8Ondgy9XEARdFmKvE5MiKUnQ3hR/+GMNzkEg4Ss
         g6TQ==
X-Gm-Message-State: AOAM533dPs6noLuNmOqX69dseiIb0S6knZcK4LGa0g0yciYClQDRP/Ve
        uD2PtYVQ4U7wKJpJPmQ0Gg==
X-Google-Smtp-Source: ABdhPJzSKRDnrny8BKo9He5QTFTcAXpqrnhpYOyi4zRLtD4q9a2RlGz5Mr2RHgWmvJf67C+lU0kTdg==
X-Received: by 2002:ac8:7d49:0:b0:304:e4ce:3345 with SMTP id h9-20020ac87d49000000b00304e4ce3345mr7305436qtb.508.1654468713846;
        Sun, 05 Jun 2022 15:38:33 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id w184-20020a3794c1000000b006a098381abcsm10168131qkd.114.2022.06.05.15.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:38:33 -0700 (PDT)
Received: (nullmailer pid 3657152 invoked by uid 1000);
        Sun, 05 Jun 2022 22:38:30 -0000
Date:   Sun, 5 Jun 2022 17:38:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krishna <quic_mkrishn@quicinc.com>
Cc:     devicetree@vger.kernel.org, quic_kalyant@quicinc.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: msm: update maintainers list with proper
 id
Message-ID: <20220605223830.GA3657088-robh@kernel.org>
References: <1654166998-14907-1-git-send-email-quic_mkrishn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654166998-14907-1-git-send-email-quic_mkrishn@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jun 2022 16:19:58 +0530, Krishna wrote:
> From: Krishna Manikandan <quic_mkrishn@quicinc.com>
> 
> Use quic id instead of codeaurora id in maintainers list
> for display devicetree bindings.
> 
> Signed-off-by: Krishna Manikandan <quic_mkrishn@quicinc.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml          | 2 +-
>  Documentation/devicetree/bindings/display/msm/dpu-sc7280.yaml          | 2 +-
>  Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml          | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml        | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml        | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-20nm.yaml        | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml        | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-common.yaml      | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
> 

Applied, thanks!
