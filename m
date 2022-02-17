Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673ADC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 14:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242266AbiBQO6K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 09:58:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiBQO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:58:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448B179707
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:57:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D474361E50
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B496CC340E8;
        Thu, 17 Feb 2022 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645109873;
        bh=HrzRuGxXxj1uEEHmrmqfEzcWIpxaXqGuQjxOWM2QryU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pgJkTcXnFqBwDNMQdVH3Mpe+y2kNs8JCs6DdvQtXQVe9bm2H39LhTmnYZht6mril
         9zHNb3FqdSBlLkAiXH4/2mRmTkMoRDdDMP0xfafCZ00qoSaBT23lO9vDMA4oQ8NJIj
         Hkq1wJVXJQZyzkMAQVF1izWUtjH7Tfi04cY4Yyek=
Date:   Thu, 17 Feb 2022 15:57:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     jerome.pouiller@silabs.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wfx: check the return value of devm_kmalloc()
Message-ID: <Yg5ibnScTz37yfCw@kroah.com>
References: <tencent_437C4189E07F1CC482B923779E839DA23005@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_437C4189E07F1CC482B923779E839DA23005@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 08:25:20PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> devm_kmalloc() returns a pointer to allocated memory on success, NULL
> on failure. While there is a memory allocation of devm_kmalloc()
> without proper check. It is better to check the return value of it to
> prevent wrong memory access.
> By the way, all the error handlers of this function return without
> calling ieee80211_free_hw(hw), which may result in memory leak. So I
> add one err label to unify the error handler.

This is doing 2 different things in one patch.  Please submit this as 2
different patches, the first one doing the error handling for the
existing "return" statements, and then the second one for the
devm_kmalloc() test.

thanks,

greg k-h
