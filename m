Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585A1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347564AbiBIEKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347161AbiBIDjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:39:11 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE05C0613CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:30:22 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n23so2019638pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 19:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Je4ysSvm0qGToTfluoX75kuGzoNSHI2qP2Y0C0VNAg=;
        b=CACwA3iWs0mIexxr+JBAReAIEm1js+p8Gd1PctwBpcCRlFarncrQq8u4LV6np8g3is
         D/VOuIRXeoPfghb+/9LTlJtNpAvNKgMSy3Wr4lug4rsCM8eyWtwax7omfbUtcsy/9gV0
         7zKe0Yw5vrIzVjXV0RntPZ6HYUDb3Ci9Ac0MxBz7ePn0Cx3ZAESjOlA/plyTn3cK/JDB
         /4GywPgMyr1VKT1Ars0+RfQs5u2gxDhVAMm6XqUo1P+6wobSWI5xZqPyxvBbdotA9rpW
         M0SPWo6TnlLbTZEqquatVpsjK0f4E620XEFwl1wrQ1s/OMsFf6/RTMOBX8yu4cXgNOQf
         8MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Je4ysSvm0qGToTfluoX75kuGzoNSHI2qP2Y0C0VNAg=;
        b=tAzs6sBbowIgpzuUz3xNCM/0lmIq6vUjHkLDU7x5hBOvXfswbyL+4lGP32BOZbuV9J
         cLpgzMFecz7efxfuBo8u/EHLjMKFVvYoiVJ+zDZYTpEDAk3ICdcyDqYX2QCFca7fpUwU
         P44/585+hGEuXNO6ZqSJrVlpAtRuMrwdah3QtpzJhra84o6k2YHyLkQBNLrOEy2G+2Br
         UDu0c0po3/zY7Fq9RURjQqKoqi2OZ6y3glG8te8tpK8AlyBnB0MEVcGkvAEZ0w4fDqyi
         Bo5CVsWfxMA+8mZKP7sT0vz6PGTJ0RLboWvf/8T5+ANFyJyyDtDKZ5aHtPkjlYsb+iUT
         +Tqg==
X-Gm-Message-State: AOAM5326US8x+NFmV0UUxvukMF1W+wJF13m2rZAg3I1Y1ShJ7o1R4wuw
        ALkkgPSpJqKowIsiJaezWNZuhDYPJ9N+3dMN859GhQ==
X-Google-Smtp-Source: ABdhPJxPkAe7JqNfPN0pMdUWTXV1LFyPzWR+xK9edhPa72Ip0qH/EBHDfJCzGhUn69nUH5cFutBmSs7V8IMhNpn2WjE=
X-Received: by 2002:a62:e907:: with SMTP id j7mr354037pfh.3.1644377421975;
 Tue, 08 Feb 2022 19:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-8-hch@lst.de>
In-Reply-To: <20220207063249.1833066-8-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Feb 2022 19:30:11 -0800
Message-ID: <CAPcyv4h_axDTmkZ35KFfCdzMoOp8V3dc6btYGq6gCj1OmLXM=g@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm: remove the extra ZONE_DEVICE struct page refcount
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6, 2022 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
[..]
> @@ -500,28 +482,27 @@ void free_devmap_managed_page(struct page *page)
>          */
>         page->mapping = NULL;
>         page->pgmap->ops->page_free(page);
> +
> +       /*
> +        * Reset the page count to 1 to prepare for handing out the page again.
> +        */
> +       set_page_count(page, 1);

Interesting. I had expected that to really fix the refcount problem
that fs/dax.c would need to start taking real page references as pages
were added to a mapping, just like page cache.

This looks ok to me, and passes my tests. So given I'm still working
my way back to fixing the references properly I'm ok for this hack to
replace the more broken hack that is there presently.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
