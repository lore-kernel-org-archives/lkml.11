Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4043CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbiDZR4L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiDZR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:56:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA44B11A14;
        Tue, 26 Apr 2022 10:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54108B80ECC;
        Tue, 26 Apr 2022 17:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562F3C385A0;
        Tue, 26 Apr 2022 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650995579;
        bh=kmZi1cLdIYN2KtLsTq/cOvLBMOfPugUMZg11JTEai0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTJJwqyiXBBu92cmm6xgE/OzGo2kOeuCuvVZXInraWOow5/RkaJRIqwWrP1hXNlxG
         p79YnJjhgHvL8+glfhuBPrrMwNJFQqfqoJpZdZDEhKqqU6cFgPNcedTC5F3G+0HsdZ
         mskrGLL7g4SttiYU2iIvRAZ9RbUbNCGoDcSSb53U=
Date:   Tue, 26 Apr 2022 19:52:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     john.p.donnelly@oracle.com
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 5.15 000/124] 5.15.36-rc1 review
Message-ID: <Ymgxd6WGhUBuntkS@kroah.com>
References: <20220426081747.286685339@linuxfoundation.org>
 <09eb98b8-6200-20c2-faa2-ced7f0e4fc95@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09eb98b8-6200-20c2-faa2-ced7f0e4fc95@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:37:21PM -0500, john.p.donnelly@oracle.com wrote:
> 76723ed1fb89 2021-12-01 | locking/rwsem: Make handoff bit handling more
> consistent
> 
> In Linux 5.15.y.

That commit is in 5.15.6, released December 1, 2021.  And this just now
shows up?  How is this related to 5.15.36-rc1?

Please start a new thread with the authors/reviewers of that commit and
we will be glad to discuss it.

thanks,

greg k-h
