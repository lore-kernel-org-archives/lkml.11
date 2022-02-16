Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7B5C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 23:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiBPXhb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:37:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiBPXh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:37:29 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B85F7C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:37:16 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso4549673oop.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Oe5Kgz/mXiBfGR7RpzB+SRCxWVkPZLeMHIEspnpgrqo=;
        b=Ku5w335Kto9e9IZrmFimPGs+b/iIGrUX73Vo6Z44mjCV8U6rWgGs8tj8L6T6QDmt5n
         MprJn7WT/14efmyzWpO5DXo4o5hV8D+l/dhhfsUHVDUXDdZaqxOzjE7eGlGM9qpB2EPW
         gMe2WRax+kFwYAj9K1eEVMnJcJ20mhrqTHsIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Oe5Kgz/mXiBfGR7RpzB+SRCxWVkPZLeMHIEspnpgrqo=;
        b=TR+byRq9/K3M3SM4XjvomyMTEG8vGgjOL9zJBLnwFzWoOu/26ZEWtOa/OZFvEczLsU
         OKnDTOu7oL8sLjFjpxXwsgffcFKoi1jsSVIn1lmeGb3gWQbi6ILBt+Ty6lUA6tmBYQl6
         lkVKGryjQ1JK+ACE115rTzKSzix/1CGC4G9sgeHvhm40OGCiGqkHFR03CGM/PZy0T1eE
         20wEokLBOPkI4uTXTXeNqyw/rPmA8XEI3gj0jxBIZ8VjsxSnI4uYU12KQJHisY3rPUFN
         qc9cTOvp7AqWllSj/HMZKzKExgk0Hsmuu4PONM1c/sM354W2QjZGV00eP/TTB407LaAj
         NEEg==
X-Gm-Message-State: AOAM531OFnXHHghv4GjV3a7Gc+bedHxzWiQc65eaCOMpuzNwKjTxkIMi
        oWl40b1VKobr2mIG+/rCVjLsp0wAhF1r9xHSYAw0wg==
X-Google-Smtp-Source: ABdhPJylun9DD0LZkQln6PAhGLyEfeA9WcQSNQlo+FLp376qtCoDluJNpTqVTuJhn94pxdcsN6ndH0jUX9bW7NquZh0=
X-Received: by 2002:a05:6870:631a:b0:d1:7d97:806 with SMTP id
 s26-20020a056870631a00b000d17d970806mr108306oao.8.1645054635886; Wed, 16 Feb
 2022 15:37:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Feb 2022 15:37:15 -0800
MIME-Version: 1.0
In-Reply-To: <1643828199-8564-2-git-send-email-quic_khsieh@quicinc.com>
References: <1643828199-8564-1-git-send-email-quic_khsieh@quicinc.com> <1643828199-8564-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 16 Feb 2022 15:37:15 -0800
Message-ID: <CAE-0n52LS5Np72MQeoX6L2=1LWzn=NDrmJJGZj629miMxrp9TA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/msm/dp: add connector type to enhance debug messages
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-02-02 10:56:37)
> DP driver is a generic driver which supports both eDP and DP.
> For debugging purpose it is required to have capabilities to
> differentiate message are generated from eDP or DP. This patch
> add connector type into debug messages for this purpose.
>
> Changes in v3:
> -- replace original patch into 3 patches
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
