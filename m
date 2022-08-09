Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A711C19F2D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 18:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbiHIS5q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 14:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348017AbiHISzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:55:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780F126ADC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:27:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a7so23717758ejp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IqVJxNw31cQs7x7vLdkBRYf56RsQMoz2IVQHanq9IpQ=;
        b=Mz533wEeIainxieri2T6/kLUzCHS1auwXeNqVpxcKibNIUElVoN7j622ZmbeuctLhd
         KBlwbRp7UoBAFyt0TTzfk3cDg+OeRcIEIG0mzz8D+bQ7jO9T8t+YG3zq/ICdBPoLblhS
         ZDLr2rEu0YOmG869ckXDpRM0fDbJcMqjQwIh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IqVJxNw31cQs7x7vLdkBRYf56RsQMoz2IVQHanq9IpQ=;
        b=T7KhxX8eBQL0iGJcpLP3Mk+/Iu+T/FdYO02ZkaBrN5lCAosAuSya3o9mXQC01xnLBW
         2NoIlPj8bpmdxOxqRTyrTfs8H/0ybSCqihuIghcNyqwDprOV7d+GrX6U469lRknjE2xm
         Nu91p1NFkXdOFankGhY9kQB4iEOlO0KjbOmGdJf54f7XYIg/HCWKURgw9cAABRYzumlA
         JguBgiOYWDMk0tysUdnz99Vh5IypUg/2ajdR6U3hx7xVS5hlWQfzn43D5a9DNo7vvS+M
         0j5qRo/QqTGs4We8khNTxC5F2Nvp7QBjDC9GI15J1weijSlVLJYI8IOE7ikGh0owfDJH
         0ZCQ==
X-Gm-Message-State: ACgBeo1fRCty4Nl9ucG9CQ02ox8ZMFJCLC10hIMAWCjde3mTR6j6mvqL
        cj7BR5AeDayANKI4POtSfqLUntwwJm00SM8J
X-Google-Smtp-Source: AA6agR6Ot4ZHT+/m28Ntuj4y7WNBvEq5MouJE5Ziq+ZZ1JzI81bFhp3Yt5lPs943f5jDwIbC31UTPQ==
X-Received: by 2002:a17:907:7b95:b0:72f:9c64:4061 with SMTP id ne21-20020a1709077b9500b0072f9c644061mr17739117ejc.351.1660069659803;
        Tue, 09 Aug 2022 11:27:39 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b0072b2ef2757csm1358520ejm.180.2022.08.09.11.27.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 11:27:38 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id bv3so15218947wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:27:38 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr6957079wri.442.1660069658303; Tue, 09
 Aug 2022 11:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220808073232.8808-1-david@redhat.com>
In-Reply-To: <20220808073232.8808-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 11:27:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com>
Message-ID: <CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still reading through this, but

 STOP DOING THIS

On Mon, Aug 8, 2022 at 12:32 AM David Hildenbrand <david@redhat.com> wrote:
>
> +       VM_BUG_ON(!is_cow_mapping(vma->vm_flags));

Using BUG_ON() for debugging is simply not ok.

And saying "but it's just a VM_BUG_ON()" does not change *anything*.
At least Fedora enables that unconditionally for normal people, it is
not some kind of "only VM people do this".

Really. BUG_ON() IS NOT FOR DEBUGGING.

Stop it. Now.

If you have a condition that must not happen, you either write that
condition into the code, or - if you are convinced it cannot happen -
you make it a WARN_ON_ONCE() so that people can report it to you.

The BUG_ON() will just make the machine die.

And for the facebooks and googles of the world, the WARN_ON() will be
sufficient.

               Linus
