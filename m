Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C10C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 19:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbiBWTAu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 14:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiBWTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:00:47 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5981C2AC7D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:00:18 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j11so10264290qvy.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSqqCbutRc3NOAh63O9doDtVioTuSu31WjglWXfHAN0=;
        b=tKpuFK1E+PFmJs8leuOw4h0lmDiMQ3C+uvL559LpZLbd6SAG5yOGRpVEVRbOq/oWgA
         u7clnWyD6IPAF89DMp/R3uvrfmm2v3jVhN9UNhw5NmvvjtSHtqJF27zzaPAULjw7PuNY
         9Ypr3K177GhK9ptRGc+aWnjsCRa3cfeyAPzcqm/hZ03OYcY7erq532eU3NeqNwqeJViE
         mVuIJ6V+4bKGT1yJLZP0K9CLUpuRUbH2RW/iWqFvx6OVxpXPo+WVtpWazNtzqlUd2i8x
         /S/CREijR7+/hA0swCqFas7+b8+McuS3Kij4CIxhoEvN/62CwZ/LoLgpooGfaNHQlDoS
         AkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSqqCbutRc3NOAh63O9doDtVioTuSu31WjglWXfHAN0=;
        b=nabxZMvlucnD8oOOkcHYcqqwESmVxr44ZUedYovMy4e9neNYIC8R0WKeczMdLAcoda
         nB8m0TKnqkpm1X66v7cLZ1HoyG2yE2/hw5Rnqf5vzNjR/qA96Nbf4fAoB4s/Fz+DYgIn
         KT22lh1x8yU+wgCH9ed7JPXrsdRmCGH7JLiXELRRKtDFvSrKJ2pjd55ofJgBn0BBoQWL
         OEeR4Fy3URxpgj99h0cNhEjj7aTL5pewHodgvJK6pIBquNNIs9gRrKvZou7TNIPKnv6v
         Dca+nK0DFlt1VWl7pqKvTC7zfUF/C0Uy61yKwI2uEFvLf0xTbP3e5/lw4ERNHs4jSgSJ
         JTug==
X-Gm-Message-State: AOAM5308ocDo98trgPa4YvZYufZ5GT+YrlEBVKd8KJeV0RAflGzyQiVV
        yZqh6pDQbaW6wBOe97ta0CnhhQ==
X-Google-Smtp-Source: ABdhPJxN/rHSuK6BkXzwfhNtgOVexDENFfblbRqCgEW2a9PUJHvn5HLXWZ+kSeOCJT7BGtE4PvG7gg==
X-Received: by 2002:a05:622a:4c6:b0:2dd:6c7a:fae2 with SMTP id q6-20020a05622a04c600b002dd6c7afae2mr1063310qtx.99.1645642817554;
        Wed, 23 Feb 2022 11:00:17 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id n12sm327174qtx.39.2022.02.23.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:00:17 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:00:16 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: remove myself from memcg maintainers
Message-ID: <YhaEQP7F9Hi7f2qL@cmpxchg.org>
References: <4ad1f8da49d7b71c84a0c15bd5347f5ce704e730.1645608825.git.vdavydov.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad1f8da49d7b71c84a0c15bd5347f5ce704e730.1645608825.git.vdavydov.dev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 12:37:42PM +0300, Vladimir Davydov wrote:
> Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>

Thanks for your invaluable input over the years, Vladimir.

Reluctantly-Acked-by: Johannes Weiner <hannes@cmpxchg.org>
