Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EF6C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 04:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiFYEUp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 00:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiFYEUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 00:20:44 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF6653A73;
        Fri, 24 Jun 2022 21:20:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k10so3246570qke.9;
        Fri, 24 Jun 2022 21:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=09kC7FfVcnhB78+kO9zvMGD0GWsTE99dXTGFN0iLY20=;
        b=lywM/YVuz2jiVdYhpE1DqEg7TT9H9+k1wZz9fS2lHRyGm3YUVbPQJjGT+t2fy4104y
         NCqeFYz2ODM1tIEnpXnd9f3DF0Ml89IVYPA86PVi7A84TMgKYiDUBp/IulGgETO7JhIU
         FOz/x8e5SZL4I1d7H9TvmGzoXl6zyXeHlF9ZmD7z0/6o9p5n/PeRYUZifTNz+dXB0x4r
         43ATRPnwIJ6L4ET+59ROCF1/f8DHmnXAzaDnSMQhGYZOdS1b7OjX4SUaoO0x1V3dGMd0
         D6/0/vaHCV3s0hvFjiYaqJknoaAY/XcQ0c/RWU3v8nyDjHm+jhBUvzMAeBYopx18bff0
         yQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=09kC7FfVcnhB78+kO9zvMGD0GWsTE99dXTGFN0iLY20=;
        b=MVmP7Dz687jecpbfo5TXudMQkGhPzGMt6/hruUNW6w+D47TNUERm2f1QPL44shANdT
         3xXySOVMjIh3s+IJyFxP8i0oPK7GKp6peC2ZDt+KBLa/MW2cFoFIzs7bWKaNa18NaDVs
         s4r19MRHp2mUiqFdkRkcAH9Yj+WmYG3Ble3EJvejV3vkDi5EC0SYxMZYCDnXDPmq1vFd
         pBj9UkAIAFMmt1YeTUjdUSy2cNbFkMqOQ1xmhDev8tc6HAbSl/mXeTEg8cvR3R/uT6lu
         87MrX021KHzfC/PeGa86K5oUtI/i6KDylnz4hpBfx2suuCUQoduXONK9FVH18IcdbL2L
         Otdg==
X-Gm-Message-State: AJIora8GBwYwdszUtNUyijeKh20opBelISQuTo+L0u0ikn+bMNxtKbHU
        TsUC6Np+CRJF/ZWRzRUCA28=
X-Google-Smtp-Source: AGRyM1uBauqAoinXn9LHijwesf0dZzH3cK/q9s7IxtilZhpP2KhdwMrSdnV+uIUC3EOR+953gPCzlw==
X-Received: by 2002:a05:620a:28ca:b0:6a7:c27:eab2 with SMTP id l10-20020a05620a28ca00b006a70c27eab2mr1771143qkp.431.1656130835859;
        Fri, 24 Jun 2022 21:20:35 -0700 (PDT)
Received: from localhost ([2600:380:5224:f7e5:15cd:bf15:6146:ee5c])
        by smtp.gmail.com with ESMTPSA id s24-20020ac85ed8000000b00317c519be8bsm2610592qtx.66.2022.06.24.21.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 21:20:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 25 Jun 2022 13:20:30 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] cpuset: Allow setscheduler regardless of manipulated
 task
Message-ID: <YraNDoxU9IZaP3RV@mtj.duckdns.org>
References: <20220623124944.2753-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220623124944.2753-1-mkoutny@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 23, 2022 at 02:49:44PM +0200, Michal Koutný wrote:
> 1) The unified hierarchy attachment behavior -- is that the
>    right/consented model that migrated objects don't matter?

Yes.

> 2) If 1) is true, have I missed any danger in allowing cpuset'ing a
>    possibly privileged processes?

Given that the someone who has write perm on the cgroup or its
ancestors are allowed to change cpuset config itself, I have a hard
time imagining that check being all that useful as a security
mechanism.

> 2.2) cpuset may be in v2 mode even on v1 hierarchy with different
>    migration control rules (but checking migratee's creds in v1
>    eliminates effect of this patch).

Yeah, it should be fine to apply the change only to v2.

> 3) Alternative approach would be to allow cpuset migrations only when
>    nothing effectively changes (which is the case for parent->child
>    migration upon controller enablement).
> 
> 4) This is just idea draft, not tested in the real case.

Unless I'm missing something obvious, I don't see a reason to keep the
check, so please feel free to test and send a SOB'd patch.

Thanks.

-- 
tejun
