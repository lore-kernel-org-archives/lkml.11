Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA729C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 06:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiESGfJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 02:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiESGfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:35:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2269466CBF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:35:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d22so3921751plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=0QO+yAJAb2csGUEWJV5Lz6AxrUMHlZtpKHVoWb0K4lk=;
        b=EYsxmJTAQ2kk+Qz75hJzyVSjLw4lrKLxgB8AAHNkivdTr35N+89e15LGk9fl81QMLi
         2n2jo/DPwomTli0zYtdSiluHSsg6CCpDxpO8cIpV+Abf8B9mpNyroaKMN80PSdICdhz4
         IkNuJtDBekdWXN/y9XVYwfGEQkLwjO5IehGV4RXOD8x70PZsafVRIMMhPgcDBuoNHNG1
         A0PlLebuEq2cDywc2Z2UuBN5NsYapPoTTGCcUXPc3/Di/43kNeVPWBRozBu0Zi4c7bwX
         EpW3qHfDFNAdn7rrzILByHZPqgwAmPnuDQ8/jSkbuPnDEAyw8jGcuvBCqE9C60RTDybe
         GzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=0QO+yAJAb2csGUEWJV5Lz6AxrUMHlZtpKHVoWb0K4lk=;
        b=YNwBSSEwtyUy7AGp5Gq79Om6/6RLcBuzwXabKeiSdVpr/fAAL8kwgdtlnQZwjS9q5p
         PF/gox/pOcSAVA8N9rhJbmnk5ThIFktGWmuEkNn6VYOP75qIdWbVbq3LnciF+3wf9zLi
         OMJJIBZV6O/HS0VADa5NUEROhzDD3l0MxfDmtF6619Ev9U+BNwo7mAvYNHf0eslLVfEm
         BOO89qkUwS1I3OgbzMH39J+QmA28EO93q5PQ7pO+coAzRG+uD4TRlITSmlMIo8UavOhm
         vxdIOlgMX4ls///BWnMm+u0JHbYkAUKI5au1m17xaQN/xAMpDqbxcyCf80+e0LzKvKIO
         wwug==
X-Gm-Message-State: AOAM533qSDsn/EQjXj3AZJf7k2g51kn3doOZg2I0Q3eV95RVSYIkpmAP
        uJflXwmJQhuo15sR448zG3k=
X-Google-Smtp-Source: ABdhPJy2ZA+96kFf9ij7hkkB623ie0jxPWismA0v9a1zRZtwMcP8ghKe+mJ01ECDLOISJgWona5rPQ==
X-Received: by 2002:a17:90a:760d:b0:1df:6423:d0b9 with SMTP id s13-20020a17090a760d00b001df6423d0b9mr4151740pjk.33.1652942105672;
        Wed, 18 May 2022 23:35:05 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78550000000b0050dc762819csm3064723pfn.118.2022.05.18.23.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 23:35:05 -0700 (PDT)
Message-ID: <6285e519.1c69fb81.4f3fe.8057@mx.google.com>
X-Google-Original-Message-ID: <20220519063503.GA1736086@cgel.zte@gmail.com>
Date:   Thu, 19 May 2022 06:35:03 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Balbir Singh <bsingharora@gmail.com>, akpm@linux-foundation.org,
        ammarfaizi2@gnuweeb.org, oleksandr@natalenko.name,
        willy@infradead.org, linux-mm@kvack.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each processg
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <YoSZE7Iak3AYA4VE@balbir-desktop>
 <6284a2ef.1c69fb81.e53cd.32b2@mx.google.com>
 <YoTjJH7+QD+DSrW8@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoTjJH7+QD+DSrW8@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:14:28PM +0200, Michal Hocko wrote:
> On Wed 18-05-22 07:40:30, CGEL wrote:
> [...]
> > 2. process_madvise is still a kind of madvise. processs_madvise from
> > another process overrides the intention of origin app code ifself that
> > also calls madvise, which is unrecoverable. For example, if a process "A"
> > which madvises just one part of VMAs (not all) as MERGEABLE run on the OS
> > already, meanwhile, if another process which doesn't know the information
> > of "A" 's MERGEABLE areas, then call process_madvise to advise all VMAs of
> > "A" as MERGEABLE, the original MERGEABLE information of "A" calling madivse
> > is erasured permanently.
> 
> I do not really follow. How is this any different from an external
> process modifying the process wide policy via the proc or any other
> interface?

In this patch, you can see that we didn't modify the flag of any VMA of
the target process, which is different from process_madvise. So it is
easy to keep the original MERGEABLE information of the target process
when we turn back to the default state from the state "always".

> -- 
> Michal Hocko
> SUSE Labs
