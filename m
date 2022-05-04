Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D28C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 21:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiEDVZD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 17:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiEDVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:25:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A54BFDD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:21:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso2340444pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MWDrNP0KVVRYtQ+s/Maj2xGGZgUlqoPwnuuSKJXHvFI=;
        b=KumagT+ulwEMT9XiJ9e4HVP6mkdQlDYEU2LKh4coIIMtKR4ch2Ifs2q/82h4nUlgBX
         gJzDkoqhZjeQvidleU5qYCDk2J0YkQm1g7bXEGLsm2ejxbd7z3w30rzLKCSY3P9U/eMl
         RVRTDSXasiIkEFcOyE84rBi+xLftsIVfa1v5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MWDrNP0KVVRYtQ+s/Maj2xGGZgUlqoPwnuuSKJXHvFI=;
        b=uF/lZ4JfZU03zVSK8qDzZJ/K3R2f+7PDTqHdOMM4z53pANDh4Rin0Wf8meQ9WvLTV7
         IIxUBZUjNqUyNlrMmrdxFQHzRSoEqtJYIQPdJg9jXtMIXFepLHobEKom1tHxapkEYDA4
         sgYY6+kaNIIGgx3+iFipuRrL6Vl6IfsEJhGJ7m2uBD1lVCqIfUova76B17Bb3gW/Wy6l
         iHDWBCA6yBXbtcYdUktc9c2q9Zk2S6bY5kZwDE9tR3ZMczIf36f4CneAQjyy64/9z1Fi
         68M1hUWbT7iyoyKZGDWaVP3XL4JFiLT7aQ/rpQ+bFwTiDC068VfurdvhM0yjxPAg1pIY
         crOQ==
X-Gm-Message-State: AOAM532zjSJrHo8CrQDVpD//Nt1QodSA+N4rjZzOjBR7ocw1yTJ11Ybq
        S9CUYcBZxVExsd9mfzZm2Sq5Mw==
X-Google-Smtp-Source: ABdhPJzpy3iZLFBU9SDFj7wyNjGD0YtKH9znWsZw5WscqVIxRlIGYTkzrrQQ5Yrifudh350pFmVv3Q==
X-Received: by 2002:a17:902:e851:b0:15e:93ac:41db with SMTP id t17-20020a170902e85100b0015e93ac41dbmr21339660plg.26.1651699284488;
        Wed, 04 May 2022 14:21:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:35b6:c77b:be04:3bd5])
        by smtp.gmail.com with UTF8SMTPSA id l17-20020a170902e2d100b0015e8d4eb2ebsm8579531plc.309.2022.05.04.14.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 14:21:24 -0700 (PDT)
Date:   Wed, 4 May 2022 14:21:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v11 03/12] arm64: dts: qcom: sc7280: Enable digital
 codecs and soundwire for CRD 3.0/3.1
Message-ID: <YnLuUrVj+VK1ay5r@google.com>
References: <1651664649-25290-1-git-send-email-quic_srivasam@quicinc.com>
 <1651664649-25290-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651664649-25290-4-git-send-email-quic_srivasam@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:14:00PM +0530, Srinivasa Rao Mandadapu wrote:
> Enable rx, tx and va macro codecs and soundwire nodes for
> CRD rev5+ (aka CRD 3.0/3.1) boards.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Carrying over from v10:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
