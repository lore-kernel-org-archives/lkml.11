Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDEBC25B0E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 01:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiHQBhi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 21:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbiHQBhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AABA95696
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660700255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kwxwoIPUtHYvH8cJiGM07yEHhTrcrM/2a4je8bRPTjY=;
        b=Tly2uKe1Ve2Vc5L5t6itYEmtd2oiI4fP87u1YeR6uNow9tZZIX4v4mKsoNpq8UGD4Sbc8G
        OIL0SD/WsEUM+Mqdv2AEyOiuBAw8T6vzK4xPb1890rafaL7EINj2fDG6K8OSnPUNSz0A/B
        wCRK3TkfhK79L+2wFeGI9cDihEaKkVE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-af6pC9CIO4yBgVussqH1YQ-1; Tue, 16 Aug 2022 21:37:33 -0400
X-MC-Unique: af6pC9CIO4yBgVussqH1YQ-1
Received: by mail-qv1-f72.google.com with SMTP id o6-20020ad443c6000000b00495d04028a6so1441545qvs.18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kwxwoIPUtHYvH8cJiGM07yEHhTrcrM/2a4je8bRPTjY=;
        b=czvaRA70ghNDprevp4mBcOalX1T98REfF3n0dAfl7CV8aLh27EzcZi9Eajg3BTdgF+
         dfrpb++/PqondlY8rAZQ7pC4pssSrERNMAjxRM7ug/kCXvK4b94N5+rFDgIkzSdu0BZT
         PxBy+Vuza4pfFZ9mNfNdzwNUgM1LsRFFmJbHitVBKktZkVbAVlNfT5bFaHyxPvscN4MV
         d+KrNJdF54ChbyXS7655YwMC2KUQkpEicj8kdp/GterzO3k+lKvywVmvXuqdjb6BzZcA
         P4fwDf00g36S4abf6tRIQSd+gVJ1aVMMaYvbkT5Wyud/WlaPGJ1i1ZV54IVZOrZhZvK2
         QJ/w==
X-Gm-Message-State: ACgBeo0mtPF3f1wB5JA856sobBW4tn5N/9n9WnPJ3unB2KJmkyg94h42
        NN9siZmxyIgUppJ81vrgM0fpQqFCJnrY9L8GwN25xViP5lIwDNLZMyJRt44vob/Y9MXNhe65KLG
        lxJAwuFzAfrT4Egdypu/jvwEdP8EkEtwT0hGzIUC67ZfW4ZHGdTBz7oPEbx5z65QOyLlJxfM6Lw
        ==
X-Received: by 2002:a05:622a:1107:b0:341:87c3:152b with SMTP id e7-20020a05622a110700b0034187c3152bmr21072720qty.621.1660700253355;
        Tue, 16 Aug 2022 18:37:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR78jn8XTvWMZrpe7oBTKwz8+yxUf3MhZKB3MfbNWTkSmTmr8nu7P26aUvbJWIaTrf78wnLnWg==
X-Received: by 2002:a05:622a:1107:b0:341:87c3:152b with SMTP id e7-20020a05622a110700b0034187c3152bmr21072691qty.621.1660700253065;
        Tue, 16 Aug 2022 18:37:33 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id d135-20020ae9ef8d000000b006bb0f9b89cfsm8310215qkg.87.2022.08.16.18.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 18:37:32 -0700 (PDT)
Date:   Tue, 16 Aug 2022 21:37:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Matlack <dmatlack@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 0/3] kvm/mm: Allow GUP to respond to non fatal signals
Message-ID: <YvxGW9IujFpTX668@xz-m1.local>
References: <20220817003614.58900-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817003614.58900-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 08:36:11PM -0400, Peter Xu wrote:
> v3:
> - Patch 1
>   - Added r-b for DavidH
>   - Added support for hugetlbfs
> - Patch 2 & 3
>   - Comment fixes [Sean]
>   - Move introduction of "interruptible" parameter into patch 2 [Sean]
>   - Move sigpending handling into kvm_handle_bad_page [Sean]
>   - Renamed kvm_handle_bad_page() to kvm_handle_error_pfn() [Sean, DavidM]
>   - Use kvm_handle_signal_exit() [Sean]
> 
> rfc: https://lore.kernel.org/kvm/20220617014147.7299-1-peterx@redhat.com
> v1:  https://lore.kernel.org/kvm/20220622213656.81546-1-peterx@redhat.com
> v2:  https://lore.kernel.org/kvm/20220721000318.93522-1-peterx@redhat.com

Sorry, forgot to copy DavidM and Mike.

-- 
Peter Xu

