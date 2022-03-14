Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4376AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 19:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbiCNToI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiCNToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:44:05 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFECA12740;
        Mon, 14 Mar 2022 12:42:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 208D3383;
        Mon, 14 Mar 2022 19:42:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 208D3383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647286972; bh=P0am7+6ONv8srDuV3nhbMZv7Ei+fkCW5So00KOZ3y4k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CNSONnFzpJL/drzfeL9vAGg5ekM5pjqrwWukXo7E2t2Ct1c8dudCTWXnffE7DOY0w
         CzFH4b9l5ZGvETC3wZ78qWyfVSM76hbfSMCIoaBXErV9XlIeE6j94uYBWCq7j2sIZ/
         6wgRLIfNUXEDa9xmRh7eRKk6y0ppJ3cP9cuoR8ffk2dScQE+aD68kkMeYi1eDNW3mZ
         IKCAU8vE4UD/jdkKCzVzPB0c3xmPETPqh5lpOwqm8/nieuxW7XeivEWlNTIGatWSPS
         lXZi7Bof4T4bcqIEYNm4eV4o5+SdKy83xBNIfr+GO/3V1/7Ev2YYuc0UoqO8ZNpkso
         870pLCWvVe12A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Williamson <alex.williamson@redhat.com>,
        alex.williamson@redhat.com, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        yishaih@nvidia.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] vfio-pci: Provide reviewers and acceptance criteria
 for vendor drivers
In-Reply-To: <164728518026.40450.7442813673746870904.stgit@omen>
References: <164728518026.40450.7442813673746870904.stgit@omen>
Date:   Mon, 14 Mar 2022 13:42:51 -0600
Message-ID: <87pmmoxqv8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson <alex.williamson@redhat.com> writes:

> Vendor or device specific extensions for devices exposed to userspace
> through the vfio-pci-core library open both new functionality and new
> risks.  Here we attempt to provided formalized requirements and
> expectations to ensure that future drivers both collaborate in their
> interaction with existing host drivers, as well as receive additional
> reviews from community members with experience in this area.
>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---

One thing...

>  .../vfio/vfio-pci-vendor-driver-acceptance.rst     |   35 ++++++++++++++++++++
>  MAINTAINERS                                        |   10 ++++++
>  2 files changed, 45 insertions(+)

If you add a new RST file, you need to add it to an index.rst somewhere
so that it becomes part of the kernel docs build.

Also, though: can we avoid creating a new top-level documentation
directory for just this file?  It seems like it would logically be a
part of the maintainers guide (Documentation/maintainer) ... ?

Thanks,

jon
