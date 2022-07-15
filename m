Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E9DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiGOWK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiGOWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:09:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2942611E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F341B82E7F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 22:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4852C3411E;
        Fri, 15 Jul 2022 22:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657922619;
        bh=Sxvx6ZHcxXw95g7niFss2ltUxP6XT+4ml9qxAH9/Dic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAkqHOXCK1TaTNDQkSOMJO+BZs9I6BOPwTnnLhXdr/yXY3wuxJrggS/WkNULPuaJO
         Qfc1DFswd2PV6chgslUh08mBt1H2+GTtxUQCdsYfQbFucQ8c3seFtNgk/CmxnxXRg+
         SsGvBUrcWg2zUROCz6AtWPi9rW8kZXZa+5AJVnZ2XqdGit1yd1na7MqzTVDngpkroS
         y4AnC7nWUcHP80aG8Uz0RXpTW7x+yIjkuYtJjmsuA98bekcD1ZuSrb91cQ154nXVZL
         NzTS41wsksuY6ebTmyUE4XsQuAXQeddz41k/UqbTnSBoKzQLWxb87tt9DR1vPUVypu
         z1a0WxzYLIdJg==
Date:   Fri, 15 Jul 2022 15:03:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Petko Manolov <petko.manolov@konsulko.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: GCC fails to spot uninitialized variable
Message-ID: <YtHkOQJ8E5cCk+Gj@dev-arch.thelio-3990X>
References: <YtHJbckxy1FJ3ts7@carbon.gago.life>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtHJbckxy1FJ3ts7@carbon.gago.life>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 11:09:17PM +0300, Petko Manolov wrote:
> 	Guys,
> 
> Today i was bitten by a stupid bug that i introduced myself while writing some
> v4l2 code.  Looking at it a bit more carefully i was surprised that GCC didn't
> catch this one, as it was something that should definitely emit a warning.
> 
> When included into the driver, this particular code:
> 
> int blah(int a, int *b)
> {
> 	int ret;
> 
> 	switch (a) {
> 	case 0:
> 		ret = a;
> 		break;
> 	case 1:
> 		ret = *b;
> 		break;
> 	case 2:
> 		*b = a;
> 		break;
> 	default:
> 		ret = 0;
> 	}
> 
> 	return ret;
> }
> 
> somehow managed to defeat GCC checks.  Compiling it as a standalone .c file
> with:
> 
> 	gcc -Wall -O2 -c t.c
> 
> gives me nice:
> 
> t.c:19:16: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    19 |         return ret;
>       |                ^~~
> 
> Any idea what might have gone wrong?

See commit 78a5255ffb6a ("Stop the ad-hoc games with
-Wno-maybe-initialized") in 5.7, which disabled that warning for a
default kernel build. You have to either include 'W=2' (which will
introduce other warnings which might be noisy) or
'KCFLAGS=-Wmaybe-uninitialized' (which will just add that warning) in
your make command to see those warnings.

As an aside, your mailer adds a "Mail-Followup-To:" header that was set
to LKML, meaning that you would not have seen this reply unless you were
subscribed to LKML. Might be something worth looking into.

Cheers,
Nathan
