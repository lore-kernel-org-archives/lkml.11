Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEA4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 07:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbiBYHGi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 02:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiBYHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:06:37 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30711E016C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:06:03 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 5A1CD2013FA;
        Fri, 25 Feb 2022 07:06:01 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id BA8ED802B3; Fri, 25 Feb 2022 08:05:43 +0100 (CET)
Date:   Fri, 25 Feb 2022 08:05:43 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: cleanup UUID handling
Message-ID: <Yhh/x2C0b8QvTm2N@owl.dominikbrodowski.net>
References: <20220224220958.93263-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224220958.93263-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Feb 24, 2022 at 11:09:58PM +0100 schrieb Jason A. Donenfeld:
> Rather than hard coding various lengths, we can use the right constants.
> Strings should be `char *` while buffers should be `u8 *`. Rather than
> have a nonsensical and unused maxlength, just remove it. Finally, use
> snprintf instead of sprintf, just out of good hygiene.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
