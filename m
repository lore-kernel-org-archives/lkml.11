Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56481C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 09:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244070AbiDGKA3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242642AbiDGKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:00:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31541546B9;
        Thu,  7 Apr 2022 02:58:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 18CC71F45CC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649325506;
        bh=4JhwlWRjO0CnzyWEzVO1sVOFEnHl7+kZT9rj4eGLerw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bNraVnOH9Rg8cMTjWdgj0JSpgVHxQRUECNA+C7JwxDOZVVd0Rs+ZVbOD6eCeaEUK4
         amfTO9YV0GuLdFz5iQU1LRj6lTD/kORLNt0j/xbgUUK+DAYcw1UeWYIEwFFurSEVhO
         j1i1gLkCk2q2rA1sQUjmeR3ODlI9uncSekbN41AqAnmfqfVFbolxRbb0H47irTI3wc
         XdQzJ0Srp5LbqDY/5actT3/tKAK+c2CaKD9XMyjzyQ0gpM7VdaBSrSVboK5Qv6JQyF
         QEv1uO6wjLeDoGRDLnuLFlxTBZaJt4DgjSehnVKF8PNKUBHK+7TK7nXC9lvWS7QKQh
         zxwjFqJZp6v6w==
Message-ID: <2fd35c28-0911-df87-c7e4-f7cbdba1f09d@collabora.com>
Date:   Thu, 7 Apr 2022 12:58:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 10/10] drm/msm: Add a way for userspace to allocate GPU
 iova
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Emma Anholt <emma@anholt.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220406214636.1156978-1-robdclark@gmail.com>
 <20220406214636.1156978-11-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220406214636.1156978-11-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 00:46, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The motivation at this point is mainly native userspace mesa driver in a
> VM guest.  The one remaining synchronous "hotpath" is buffer allocation,
> because guest needs to wait to know the bo's iova before it can start
> emitting cmdstream/state that references the new bo.  By allocating the
> iova in the guest userspace, we no longer need to wait for a response
> from the host, but can just rely on the allocation request being
> processed before the cmdstream submission.  Allocation failures (OoM,
> etc) would just be treated as context-lost (ie. GL_GUILTY_CONTEXT_RESET)
> or subsequent allocations (or readpix, etc) can raise GL_OUT_OF_MEMORY.
> 
> v2: Fix inuse check
> v3: Change mismatched iova case to -EBUSY
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++
>  drivers/gpu/drm/msm/msm_drv.c           | 21 +++++++++++
>  drivers/gpu/drm/msm/msm_gem.c           | 48 +++++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_gem.h           |  8 +++++
>  drivers/gpu/drm/msm/msm_gem_vma.c       |  2 ++
>  include/uapi/drm/msm_drm.h              |  3 ++
>  6 files changed, 92 insertions(+)

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
