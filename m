Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78498C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 22:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiEIWIG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 18:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiEIWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:08:02 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECDB2A83C7;
        Mon,  9 May 2022 15:04:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 889D6732;
        Mon,  9 May 2022 22:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 889D6732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652133846; bh=jB4LpymYnzlG4qkZC/mQ2W7zByxYnZ+9R68QH+RF8yY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SlHX6wn0QfP8+qUnqCJGoiUdYZkk8AWL+hDaUDZWwHoup9pUa0Ip1JoeqO2Fmg2KK
         jK+xuMG5QRljmWeixwlxBSgQqxGuhYvEMSTgvtaSQ6tefysZ0qEwIghojEOVk03uzO
         sy/HG9gpPOsbmmIfVIcEGm61U2aBBVMvNbqFIdV91ojbFzR1omFhvkVj4nazS4PUs9
         oPBuj+GxEaFokq6Jtcuo7gm8hXySCA4SJVLJEuMnXWxU5/XcRPSKyXszm/bCH2REWn
         DshdXRz/CwCoTSunpCIZNbUgz/oBE2c6jtJTUrk/NbvoRh9ZKa+kcUDc03Uk4DDuBf
         +kOl+Zw6jZyfA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] docs/ja_JP/SubmittingPatches: Trace changes in
 English docs, take 1
In-Reply-To: <20220503102429.48304-1-akiyks@gmail.com>
References: <20220503102429.48304-1-akiyks@gmail.com>
Date:   Mon, 09 May 2022 16:04:05 -0600
Message-ID: <87mtfqcqi2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Hi,
>
> This is the first batch of updates attempting to modernize Japanese
> SubmittingPatches.  Conversion to ReST will be done later when the
> corresponding commit doing the conversion is reached.  Pending list
> of commits is quite long (about 90) and this effort is expected to
> produce dozens of series.
>
> List of commits for English (then) SubmittingPatches:
>
>  - f5039935ac68 ("Documentation: update GregKH links")
>  - e52d2e1f25f0 ("Documentation/SubmittingPatches: suggested the use of scripts/get_maintainer.pl")
>  - 755727b7fb1e ("Randy has moved")
>  - 8543ae1296f6 ("checkpatch: add Suggested-by as a standard signature")
>  - 0af5270324cc ("Documentation/SubmittingPatches: Request summaries for commit references")
>
> Note: Commit db12fb833a88 ("Documentation: fix spelling error in
> SubmittingPatches") does not affect Japanese translation.

Series applied, thanks.

jon
