Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DBCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 16:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbiBJQ5O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:57:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244697AbiBJQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:57:06 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC39D4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:57:06 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 7FB0620133D;
        Thu, 10 Feb 2022 16:57:03 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id ACEC1805A4; Thu, 10 Feb 2022 17:46:10 +0100 (CET)
Date:   Thu, 10 Feb 2022 17:46:10 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 1/2] random: move fast_pool/fast_mix definitions to site
 of use
Message-ID: <YgVBUiomkFz+RUit@owl.dominikbrodowski.net>
References: <20220210160925.156697-1-Jason@zx2c4.com>
 <20220210160925.156697-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210160925.156697-2-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Feb 10, 2022 at 05:09:24PM +0100 schrieb Jason A. Donenfeld:
> No actual code changes, just code position changes. Having to scroll up
> and down by several hundred lines every time is confusing and hard to
> follow. Instead cluster these together. Later when we're redocumenting
> the file, it'll mean a smaller delta.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
