Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84794C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 22:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiGTWDE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 18:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGTWDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E33004E848
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658354579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c6jnvbTZSWYjkjxxL2h3wZQ+s22j9f6nKt+O/48X9rA=;
        b=V55EVow13i2nSvlHfncBsJL3KBJQCD2lxetMUd4XyO8BduW06GyqiYAaihjsK4wVxr2Xhv
        3BDqxo5wfGpkY4s2apNS8/SbBqfYa0tZOjUxSfeqZz2dWrKBLvZp12UUY7xWCSEKr8oqeI
        XLl662wWL2mD4I+1dqXWm/ZW0v6ARt4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-IG-tR0DtOHWGfvLAOeBqzQ-1; Wed, 20 Jul 2022 18:02:58 -0400
X-MC-Unique: IG-tR0DtOHWGfvLAOeBqzQ-1
Received: by mail-qv1-f69.google.com with SMTP id k7-20020a056214102700b004740a13b3bcso971049qvr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c6jnvbTZSWYjkjxxL2h3wZQ+s22j9f6nKt+O/48X9rA=;
        b=4B4pZw5nVfyqPK2CxkxH3fPfNbDKjG2/rNwflTB8dEkgqVH5pJ28fbYUrAdI0tQpYT
         +hfFL3m/oXYfLSuWsqrMYbaaaTxsLcOYB0ZijoY1GRo82v1n63Qm/lWWcnzJNJPv1FXW
         OFJRPi7G/zaxNdG8hTsarxN3OfSdQYLwNFnfHho0TnYWD2X9EojFAPd+Sakmmkf5zatT
         h5fwOJv3i8oAkDF79IxfNiSBY9tEW3Tb+m75G+zpsWXPZ8T1p9oJF/nMKKtHGe60pvWj
         eXTaqrvSzA4qmPry0lt0Ac70D+kOqhTFlqtmzaMSsigVMhaS07Jhzw4ECDSmMJAwy03X
         q1aA==
X-Gm-Message-State: AJIora+OzirJFOijvmbyKCrMjKVZaEp2HEPlunTkRcvlii2/4qjYjys/
        IcgLX8Ycn7XwlAplefq7PYShqZqoEMtHt6G8Er/GY8bYMI5C7AolV3sqIvp7VjQwNkvnGJToYdE
        NOZHwpZ3XsFIauYvmkbJvmaAV
X-Received: by 2002:a37:614:0:b0:6b5:cda7:694b with SMTP id 20-20020a370614000000b006b5cda7694bmr18598711qkg.532.1658354578233;
        Wed, 20 Jul 2022 15:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vKjiIammcHHHBmJOZwtJ7s3x+QWPbbcaO+hZViEQVzR62uQ1jjVGoKVLSrMmHy4Q1LBCm1vA==
X-Received: by 2002:a37:614:0:b0:6b5:cda7:694b with SMTP id 20-20020a370614000000b006b5cda7694bmr18598687qkg.532.1658354577916;
        Wed, 20 Jul 2022 15:02:57 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id de39-20020a05620a372700b006b568bdd7d5sm214499qkb.71.2022.07.20.15.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:02:57 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:02:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Message-ID: <Yth7kPbqiJcIy5Rs@xz-m1.local>
References: <20220720215319.87839-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220720215319.87839-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 05:53:19PM -0400, Peter Xu wrote:
> void clear_refs_write(void)
> {
>     int fd = open("/proc/self/clear_refs", O_RDWR);
> 
>     assert(fd >= 0);
>     write(fd, "4", 2);
>     close(fd);
> }
> 

Oops, git dropped some of the lines starting with "#"..  Let me retry, sorry.

>         bool dirty = pagemap_read_vaddr(fd, page) & PM_SOFT_DIRTY;      \
>         if (dirty != expect) {                                          \
>             printf("ERROR: %s, soft-dirty=%d (expect: %d)\n", str, dirty, expect); \
>             exit(-1);                                                   \
>         }                                                               \
> } while (0)

-- 
Peter Xu

