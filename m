Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95532C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 19:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbiCNUAK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbiCNUAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:00:04 -0400
X-Greylist: delayed 955 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 12:58:48 PDT
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0840923;
        Mon, 14 Mar 2022 12:58:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CACC5383;
        Mon, 14 Mar 2022 19:58:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CACC5383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647287927; bh=AnNaxE8wlTsBWEEhticAn+sEqcwIS4iNBDpH7ZLYvUs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CDvfTzXvXnFFBj3xyAdIntEyefM2+PlaaW8TL3DmFkeWbHStcrxtF2dpNA+BOkDIj
         zdn7mjcCDKLLmkygxJMwMqVw4bWBzvaEbM6IWjJGsVgHbERiaYfkRfm1MMkifJapKe
         G+5WMo7B4v6Q5Yr7eFzt6fOwgaUbcSSEWK00WlmFwpoBNPAoWDzS4GfjpIM6WDIKDH
         Rd+zBy2C36Vnf9cv680u02iVT7ljK1Js7ZrE2PUZj+39TVj6BiLTbowuzgdo7G5fkp
         DPL4ZAf/fs/YKg/hDykFITs3wTtIKaWkAdFOlwjzwX9dW+kUilpndb+8/9oYnL7HvB
         U8w7JKvVebuqg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jgg@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        yishaih@nvidia.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] vfio-pci: Provide reviewers and acceptance criteria
 for vendor drivers
In-Reply-To: <20220314135216.0cd5e16a.alex.williamson@redhat.com>
References: <164728518026.40450.7442813673746870904.stgit@omen>
 <87pmmoxqv8.fsf@meer.lwn.net>
 <20220314135216.0cd5e16a.alex.williamson@redhat.com>
Date:   Mon, 14 Mar 2022 13:58:46 -0600
Message-ID: <87lexcxq4p.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson <alex.williamson@redhat.com> writes:

>> Also, though: can we avoid creating a new top-level documentation
>> directory for just this file?  It seems like it would logically be a
>> part of the maintainers guide (Documentation/maintainer) ... ?
>
> I'm not sure it's appropriate for Documentation/maintainer/ but it
> would make sense to link it from maintainer-entry-profile.rst there.
> What if I move it to Documentation/driver-api where there are a couple
> other vfio docs?  Thanks,

Sure, that's fine.

Thanks,

jon
