Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F71C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 17:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbiBJRNB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:13:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiBJRM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:12:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A11A8;
        Thu, 10 Feb 2022 09:13:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9609561DD3;
        Thu, 10 Feb 2022 17:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7015FC340EB;
        Thu, 10 Feb 2022 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644513180;
        bh=Te2mhSy45Q5nEGKWCJFmASXitEiV2m8w4DTe7Pvhs/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/iR7PvQfYeuOHEiBZHcEotatjagDXQqSATQaGXKP+H9jClLErDU9fr6hz4tNDZi5
         FRSPzMXBKhpbQn2gjusVxE+XpdVjpCRe2xxkWVSy+y64nULDOStqbPP+9jYARCKpNC
         5EwOBc4zO8SfnzgHwXAEpU5Voo9e7nYOvUM6tQG8=
Date:   Thu, 10 Feb 2022 18:12:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v3] random: add proper SPDX header
Message-ID: <YgVHmRCBe85YFLLg@kroah.com>
References: <CAHmME9q5uExD5bUdPscZn6mKQYnf80YPq=KqCk8XYuH1uXpS6Q@mail.gmail.com>
 <20220210170651.163974-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210170651.163974-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 06:06:51PM +0100, Jason A. Donenfeld wrote:
> Convert the current license into the SPDX notation of "(GPL-2.0 OR
> BSD-3-Clause)". This infers GPL-2.0 from the text "ALTERNATIVELY, this
> product may be distributed under the terms of the GNU General Public
> License, in which case the provisions of the GPL are required INSTEAD OF
> the above restrictions" and it infers BSD-3-Clause from the verbatim
> BSD 3 clause license in the file.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v2->v3:
> - GPL-2.0-or-later is now a vanilla GPL-2.0.
> - Remove non-license changes.
> 
>  drivers/char/random.c | 37 +------------------------------------
>  1 file changed, 1 insertion(+), 36 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
