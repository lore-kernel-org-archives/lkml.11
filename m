Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A581CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 19:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbiBGTbN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 14:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239242AbiBGT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:26:49 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66984C0401E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:26:49 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id g145so11850153qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bGzAS0zKkWkFPCiUJqrRhTBAlrJP3SGf1MGlPyahzN4=;
        b=b7ELmtzNyf/nrudljsQzl4Q1Js/C7bJel76vjls1xYAgKYUp0D32NW/dwCQI91vZZP
         cXbYYhEP/g8elhxNJkVvAoFewT4/BqI63tG4dQgRBW68M7alExU2eUsV3nwL+RRGhNfV
         j9OssUbyMS/ts/M6+OwPFFARzPDqKR87URSREqouyR+yUBPPCOc+h8b8yGuU3ej+D/xM
         yigD/3UGPd7ytRh96Y0Q0EKXaGboDozlOgbEE8YSvDdrFF+CXBdAOzxWkzfsUC5OZ96L
         FougQ7rtCxrXPxFtxmHqPYYsSOKmfZn62Sni/waJLdqf1/0D0HpcPN3YMwknPx6e2shw
         Hl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bGzAS0zKkWkFPCiUJqrRhTBAlrJP3SGf1MGlPyahzN4=;
        b=W865r7rgIrbEOm/2Ro+1vmfaUrMJq0LOQYNfQCLT09QIGML6EWU2H0+qyctQZnSXjQ
         dsvuOhggR75qrm60GICqdOR9SXTJ+SF9iQ0XkKZcuBDQ8Tc0chmCD+sPcodq3cTO9M2J
         +oRZ3bZZ7fuMCT6ZPlR5bCYXSVgXRO1IvP+ZkFbXLmUBcgq3CcY4+/mooYysJZx0omYz
         Fde1pBCG5dWdEB7uLV+aGjZVhdRYpZ02oAiThYBaDdP/7UkP17nf0y8xm2UM/lIhe95L
         tkBFuvBGJSl7yhug/znrZVPO6JKPDg7avpwdHo5Q2B3oXZCiCJGjPXJ3kubK0g1/I/qE
         6uiw==
X-Gm-Message-State: AOAM533bpXJUskCQNsMFma2NpPExr++Ieo1peBd3Q++BM571yxf8fG7E
        FxesV3sXlaTKpWO5FYe2g9+9Lg==
X-Google-Smtp-Source: ABdhPJyr6K2wB/TmouPqeHofF9/cBL8QhnN30S2Z0xEYqLSWtmQW56XluhEWaS6dhmSL4EVhM8SlGg==
X-Received: by 2002:a05:620a:1204:: with SMTP id u4mr761415qkj.707.1644262008607;
        Mon, 07 Feb 2022 11:26:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w8sm5913769qti.21.2022.02.07.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:26:47 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nH9ex-000HvP-5E; Mon, 07 Feb 2022 15:26:47 -0400
Date:   Mon, 7 Feb 2022 15:26:47 -0400
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
Subject: Re: [PATCH 2/8] mm: remove the __KERNEL__ guard from <linux/mm.h>
Message-ID: <20220207192647.GD49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:32:43AM +0100, Christoph Hellwig wrote:
> __KERNEL__ ifdefs don't make sense outside of include/uapi/.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
