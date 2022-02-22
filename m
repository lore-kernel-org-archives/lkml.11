Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979A4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiBVRVP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiBVRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:21:14 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C093B16EAA7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:20:48 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w37so11203031pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Kdmt3ze8hhv2ohAv917Xh8Gl81wMXYQqTjTVOulWto=;
        b=i3hDE5w5/2c64xKaly5BmvmYqGgj0/JjmjBTcJzSJ/KiLIQg8QwnIbzG12JWva4k3Q
         XuxpOQzRLlkEPTjx41WACDPY4F2W1zAJ1ERUpvOw1/eLvxTyNtf+a70Gn71aX1Y5LbQ6
         kvboUXJ9zsRs1SQv3F3L50jDtpmaoLVLmkx0Hh0PUwVjyYnSFs6MUKnUUngLAlpDZRID
         kF/odbbK+kCFPbrsq5K5yoZOn6LeNvim2JDU9fVhjEx3XnbHbKNUQlRRFl/gBarwHhU3
         YLVcSJ0h+7QbN053XZtkBVxLNI73s3yUjZVq4N5EnXihjxuGFMlk/AqYVIDZ2e2UwTAQ
         hufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0Kdmt3ze8hhv2ohAv917Xh8Gl81wMXYQqTjTVOulWto=;
        b=CNve3mWPO4xb9h7bq2KChNURYyfnLpgeo40dJTGKejZDLDkvL9AzKzPxfbGoAbEawI
         sfj5GRKnCQ85Fz/Imu/OrLIpXYoY76OB+aKtkJARYZ31RHbQGbuk7PvhcsZAhPIRfhEC
         MwJN44S5OTkRKJrLsimJxF55b532T8W62voWYg8Mj5zs2US86Lwmw3sSdmR8aSiEnVq4
         sdT6yzo/+Y+uc/x2NnXXi40Xo8t9bX4BD6xNqTVXVVEM6uJ6zuhZgxJkU6zoNgzNJswc
         eP/BA858MEbugCBOICYtvoQYc/+U1aGZBXunmOmE3nVN5xB8Gbck1RLKFtuPiXCjUjaf
         yfcw==
X-Gm-Message-State: AOAM532Ww3WUo6p0NdvRpf2bDGs71Di8EG/OrBvaRtvgdBdaH6PpyqJ1
        RwM3S8F1RvRMRlOCvfOA5Fs=
X-Google-Smtp-Source: ABdhPJxPSQWc5i3N0LAjK9HLEOGM6ROYSQy2OM8vZFchfrfAKztYmxRAaN++5EJuvG/dZvrf+Vrm9g==
X-Received: by 2002:a05:6a00:1a04:b0:4e1:294:e1e5 with SMTP id g4-20020a056a001a0400b004e10294e1e5mr25373400pfv.51.1645550448173;
        Tue, 22 Feb 2022 09:20:48 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f3sm10563153pgi.57.2022.02.22.09.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:20:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 07:20:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH] kernfs: move struct kernfs_root out of the public view.
Message-ID: <YhUbblMhjDBH5X+x@slm.duckdns.org>
References: <20220222070713.3517679-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222070713.3517679-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:07:13AM +0100, Greg Kroah-Hartman wrote:
> There is no need to have struct kernfs_root be part of kernfs.h for
> the whole kernel to see and poke around it.  Move it internal to kernfs
> code and provide a helper function, kernfs_root_to_node(), to handle the
> one field that kernfs users were directly accessing from the structure.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Imran Khan <imran.f.khan@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
