Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFFFC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 18:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351151AbiD1Sjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiD1Sjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:39:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88382C11E;
        Thu, 28 Apr 2022 11:36:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 01F0637A;
        Thu, 28 Apr 2022 18:36:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 01F0637A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651170989; bh=XPxBsOv3MHPpWdaP+RHY5sGiWu6noKHQxvTjG9bbEUU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HuF2gwly9ra7GSKC9Ok41SvRF0iV8QH8/JUjflHrj+kqMK9VZwdzo0+t3SyEfpHMb
         cPEH44p+bF2X6bC9rawA95KHX/CqhKB8dB9wfmrDT43yfz1I1zvoWEh2aWzUXn/Arw
         PINF+cuEyRmWEVBKo1yXGPuArok+2NbIcNKjfIzWxjn3MAG6oXApAFQYQa5So7trI/
         YygHgHtWAHTioDUwJUOhwGHwFudxGmNvoRvIGPIvwYgYiluolilCNy9+xOBJYTk7Zq
         co9QBJqyr3X8DU4X7rIF0UTnTU/zna/VCGtdE35PjGLTO7+jG4KcWfKic123HpYIkF
         ryqIS9C7SZJcA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] Documentation: add missing angle bracket in cgroup-v2
 doc Tejun Heo <tj@kernel.org>
In-Reply-To: <20220422164526.3464306-1-jsavitz@redhat.com>
References: <20220422164526.3464306-1-jsavitz@redhat.com>
Date:   Thu, 28 Apr 2022 12:36:28 -0600
Message-ID: <87pml15a37.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Savitz <jsavitz@redhat.com> writes:

> Trivial addition of missing closing angle backet.
>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 69d7a6983f78..38aa01939e1e 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1881,7 +1881,7 @@ IO Latency Interface Files
>    io.latency
>  	This takes a similar format as the other controllers.
>  
> -		"MAJOR:MINOR target=<target time in microseconds"
> +		"MAJOR:MINOR target=<target time in microseconds>"
>  
Applied, thanks.

jon
