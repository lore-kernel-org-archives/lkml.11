Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855A3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 20:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiDLUEF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 16:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiDLUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEB6112ACA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649793270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BG3/E0804YNTvYQ1PSJhW2iIHIF4qaN9/7glgCGt4RQ=;
        b=AM334bGxmuLjUKN4kNrX9mfz4B02u/m0cc8hJ/BLVNs4fg3Zo3Zl7qejs+MtstD6XCJmj0
        3wFmkQV/HETsKHKAYR+rZucpVF7MFl1dSyFKGgM1TK4msjTqJqRKjd9dS0pT+fMsZZgflV
        j0eOsYYqWIPDxG8OhEUYtlCKiQFkj/c=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-XSoYSSxPPKuq4vq8yHTjiQ-1; Tue, 12 Apr 2022 15:54:29 -0400
X-MC-Unique: XSoYSSxPPKuq4vq8yHTjiQ-1
Received: by mail-il1-f199.google.com with SMTP id d13-20020a056e02214d00b002cac9752b15so2595475ilv.21
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BG3/E0804YNTvYQ1PSJhW2iIHIF4qaN9/7glgCGt4RQ=;
        b=say8S4jVPYhIo6x+aBBrFg9IXmBpS4qpahrlXv3lt00xxWB8pE4zoRGwZI7BdUULVE
         dpovkQ3YTA15UeTY4AI2FVXbrut/xhums6OfuTu6lq7SOuCAZjhrPD2E+8cqz5qrm8AX
         tLTZFZPEmrfo6w+hn2PgQ4KwfBKR56jEVhGK+rR8afoDp2B3P1H1O03idWa2WcYZQnzR
         S9rY0DtQywHyC0aK8G5jmDqAcEGH9L9u+NpbLBlI5fzRYy/Hyohn2jxWlB7vmJnmPtX/
         bVl9tVqnX0A1gHpvprreKY4FWGaEqKK2hFsVx2WEchyYQSaqScpOjKQRYGux524aIzo+
         4odw==
X-Gm-Message-State: AOAM532xSA62d7suO5uY6T3UhwrvpxNSe0UiTXG3ABqHE90vIdtIMiOw
        HKj5A00ljaRVR71pWyEie8m1uZTFqxnjYsPofjRrO8Tz//FzaIZfn7jT9qS1h0jg3wcvjs3WnJT
        T7t9N9d4E9YxRkAlEthVNRRwF
X-Received: by 2002:a92:ca45:0:b0:2ca:810e:7855 with SMTP id q5-20020a92ca45000000b002ca810e7855mr11518619ilo.303.1649793268878;
        Tue, 12 Apr 2022 12:54:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygDnYfR4vWuyoEcRh0/ZR4FdF8V+vokV8y66/CDLdiMKA4IP6VKoD2OKcfu+L/f6WYCk1z7Q==
X-Received: by 2002:a92:ca45:0:b0:2ca:810e:7855 with SMTP id q5-20020a92ca45000000b002ca810e7855mr11518604ilo.303.1649793268704;
        Tue, 12 Apr 2022 12:54:28 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id ay18-20020a5d9d92000000b0064c77f6aaecsm24086108iob.3.2022.04.12.12.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:54:28 -0700 (PDT)
Date:   Tue, 12 Apr 2022 15:54:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Message-ID: <YlXY8oWDWGCtjE/d@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014836.14077-1-peterx@redhat.com>
 <878rsbawd2.fsf@nvdebian.thelocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878rsbawd2.fsf@nvdebian.thelocal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:05:41PM +1000, Alistair Popple wrote:
> Looks ok to me now and should work for all architectures.
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Thanks again for taking a look.  Currently the series is queued in -mm
already, but I'll take these R-bs if there'll be a new version.

-- 
Peter Xu

