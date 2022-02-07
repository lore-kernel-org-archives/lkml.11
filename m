Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC5EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 19:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiBGTgE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 14:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbiBGTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:35:01 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06649C0401EA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:34:59 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id p14so12918425qtx.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9c7vpxYS+6RnfIRFWhHgAcQnmpWWsCXDoIZ8HfcxKVk=;
        b=eyrwc8BMMdOVC7JxxbPkKv0E+7XYg1mWVnxya1gkeBbn+6FIIKA4h5dIP4xxQ6Lyue
         PP3XS1TlpffXxqvfwJvChxVJKrRaJ4INlob/J3j8V4nhPl1/nALzUS4bebpDgN+o/Aus
         QQg2zEZcdkmCLgeogf4eYK3AO+nmond0PimC6gBZEbdgCdCPZ88/G1CIEJ9vhbSZK4os
         tk4KtyYHQy6WXksXzSrn8f5eOqxd/45+LU03LL1E7V5s7Z/zSb/UfyVa4YpBFVPoHCin
         OF1OweCzorEMyWiZQI+JHPsC+t/W26GR57RXRrAWC89poKcjeNO3WJ+VmGSwbNpLPdn4
         ljZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9c7vpxYS+6RnfIRFWhHgAcQnmpWWsCXDoIZ8HfcxKVk=;
        b=SqvGiiPWVPTZAEUSO0JQcE2v+UhyoEAFcCtt0K5yRiGymyQfu8Mli5/27cOLB7jXXs
         5xvLcEqfmcw/AwUfiBYRa71iRa4fCUwjY2TmXRomUBsV8sA83CSzwFYKwxgI5HcGCRxJ
         IlRV0oa9W0CUBw9a2t3mIyT2N6CBB9ePqfW1tkN8C7c/moqHNZP67L7iLMCFgjFPpHCf
         knXzbWsj2lN4ZnEGx7tNzWvYuXZGN4V+Iuw6h9gM1JMe8apnUGK76uvMn6eRoiZLMszC
         dCy/4DwpsVqTXIbSuxA6XOZd9u0+wN28yEwJfc5vilxFI8OupRQVxdCgVyodGLh/l02s
         tHhg==
X-Gm-Message-State: AOAM530vSnnh0eZnsf8vX5eucRJrqWILPft9Whr9C7gGHJY39oAi7cSU
        40OWa3DnhCRAWvv48EMajXyZFQ==
X-Google-Smtp-Source: ABdhPJyvD659xk5KRCKkhy7N4LjGPrkEHjwUHp/EZt//+nT6eRHPcHoug24DbpSsFF9r7utyh5WJCw==
X-Received: by 2002:ac8:7507:: with SMTP id u7mr761226qtq.518.1644262498222;
        Mon, 07 Feb 2022 11:34:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id o18sm6033304qkp.26.2022.02.07.11.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:34:57 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nH9mq-000I5O-UX; Mon, 07 Feb 2022 15:34:56 -0400
Date:   Mon, 7 Feb 2022 15:34:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 5/8] mm: simplify freeing of devmap managed pages
Message-ID: <20220207193456.GF49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:32:46AM +0100, Christoph Hellwig wrote:
> Make put_devmap_managed_page return if it took charge of the page
> or not and remove the separate page_is_devmap_managed helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h | 34 ++++++++++------------------------
>  mm/memremap.c      | 20 +++++++++-----------
>  mm/swap.c          | 10 +---------
>  3 files changed, 20 insertions(+), 44 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
