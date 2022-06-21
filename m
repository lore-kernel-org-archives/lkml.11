Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A9FC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 09:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348736AbiFUJ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 05:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347928AbiFUJ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:27:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C2240A0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:27:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c2so21381850lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ifnIPViM69Gn0EtfiMceiQQ3U5cbSISeqEVjR7goDIQ=;
        b=dRU8sRBPetUucKScVySr3WRQ0R4LCu1DEpsBwORL7FYFPBN5BGy3HuK9y49XOmz8Td
         DUfO/e1VAjE+mzdyDbSi6N/NvsKm+3Kx2vew3EsD94+ptUZiWS9XY7HEyAiB+IP74Epo
         3lorCqyPNzIYRm3Xrrr+OQpGe8gNCAjk/jM0Nz+OJv593D9uCLHx+kof9N1l5MTaHWTr
         6m47+eiioV/r1dvLj2pz0IwzFytqV+/8nJuKABLj+HYrRArlic0M67GaNRA78SeKpWjc
         7IUbdd8WHobLYqdml//X3FipOi0fPzhrrJ5Dj0X5vhheKEeA/fC3OXN1uiuGPoDSvWVb
         temQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ifnIPViM69Gn0EtfiMceiQQ3U5cbSISeqEVjR7goDIQ=;
        b=R2ADJ7kAMW07T1ozj5XDEJGrSyCVEebcIROoTph390v5NpohJnQMmTTUXbbN6shI7L
         Jq6dQh/MqtWeyxeR2xxVabSi6sdv+t1hq6Wpfds/rjSHouCrCuJSDKWm/8mKtWpmfMGY
         7T1GUMlLokpKIACE4IdQ1kaj9fSA6iP21jexyxrDGmU+RPxnELKbQYNdeCuTqs3zFBhS
         YfxbPVJwCYukRDj3ydC/E32kI2LTq0Na0nqEx5cTONRCp41A0ovaIVXmsAS3E69BTaMS
         3J1eTKTC+slifEdYhcuSXDASIdrKW7kBuMsJehxUZj0+92hq4uey5URPXi81EROhWx+J
         HLcQ==
X-Gm-Message-State: AJIora/mwlF6UPdzlPHui20L1f4NSc0Ob2mXFS+i6WG3ZHDHHHlwjgMr
        qa8YzaplqdUecfsnA1RpWS8=
X-Google-Smtp-Source: AGRyM1uErMFknRztKhYJ14KRUNJAqza0eTiI80x4rR3SsB9hpWmAw7pDVh8SIeiywFQKLmqvAax/jQ==
X-Received: by 2002:a05:6512:2292:b0:47f:68b3:3c21 with SMTP id f18-20020a056512229200b0047f68b33c21mr7188798lfu.316.1655803619701;
        Tue, 21 Jun 2022 02:26:59 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id n8-20020a2e7208000000b0024f3d1daeaasm1934476ljc.50.2022.06.21.02.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 02:26:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 21 Jun 2022 11:26:57 +0200
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm: fix racing of vb->va when kasan enabled
Message-ID: <YrGO4cae/03r3PzP@pc638.lan>
References: <1653447164-15017-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAB8ipk9cAoP6yV_-Gn8bwbn5ezCZujLeMpioa0TiNU5=akBaug@mail.gmail.com>
 <Yq+PMWlARgDhv8uL@pc638.lan>
 <CAGWkznHPdk_yqn2GWPDJaT32+4MnFLnRjdjBkaFv9BLMh4yM=g@mail.gmail.com>
 <CA+KHdyXpdow7SYsbq_7F0zDd5-nYGi6db7R11R3--g3gUu-59w@mail.gmail.com>
 <CAGWkznE5cFfdtmQ2j57goWtpfPGYPsd5Oi3pvb9vcfifodR9OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznE5cFfdtmQ2j57goWtpfPGYPsd5Oi3pvb9vcfifodR9OQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jun 20, 2022 at 6:44 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > > > >
> > > > Is it easy to reproduce? If so could you please describe the steps? As i see
> > > > the freeing of the "vb" is RCU safe whereas vb->va is not. But from the first
> > > > glance i do not see how it can accessed twice. Hm..
> > > It was raised from a monkey test on A13_k515 system and got 1/20 pcs
> > > failed. IMO, vb->va which out of vmap_purge_lock protection could race
> > > with a concurrent ra freeing within __purge_vmap_area_lazy.
> > >
> > Do you have exact steps how you run "monkey" test?
> There are about 30+ kos inserted during startup which could be a
> specific criteria for reproduction. Do you have doubts about the test
> result or the solution?
> >
I do not have any doubt about your test results, so if you can trigger it
then there is an issue at least on the 5.4.161-android12 kernel.

1. With your fix we get expanded mutex range, thus the worst case of vmalloc
allocation can be increased when it fails and repeat. Because it also invokes
the purge_vmap_area_lazy() that access the same mutex.

2. You run 5.4.161-android12 kernel what is quite old. Could you please
retest with latest kernel? I am asking because on the latest kernel with
CONFIG_KASAN i am not able to reproduce it.

I do a lot of: vm_map_ram()/vm_unmap_ram()/vmalloc()/vfree() in parallel
by 64 kthreads on my 64 CPUs test system.

Could you please confirm that you can trigger an issue on the latest kernel?

Thanks!

--
Uladzislau Rezki
