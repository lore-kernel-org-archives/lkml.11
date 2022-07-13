Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F7BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 06:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiGMG3n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 02:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGMG3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:29:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F127B03;
        Tue, 12 Jul 2022 23:29:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B87F9B81A5E;
        Wed, 13 Jul 2022 06:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5D9C34114;
        Wed, 13 Jul 2022 06:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657693777;
        bh=ab1/DOuvFaeHqxdg5cBmKxgsrk5XBOsxMr01sjJKmY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyfznCEbqnfpGih3owDDktOXmpIZCzRYM+qF6sGOW6sin62dKBNjkqwF3k1l19spO
         2wyOssQ1GZB1/us/efbFTt85UDKfYFfT6KlWa2mv+/hyB7syVWCspHGBzblFEsus5I
         5dE3DzhGssL3lsnWAwt6qz60kO8XuKuOCf2NphAOaHonxPf5bLTThaYF2ORuOMOmgu
         8GIjNzibi5pWAN6ceqfSB857tOABhbpBP1P1Yx/Q6lzRBY+oOTfPqsR6/8jzUWTXXI
         NpyWtaA7RnX2U0zl9WSx6XswdykDPr+RSpAu24rd1/XQ0fNCw6xCxLJuZIyBtEzhzL
         lieTZouGk5Oww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBVsS-00035V-Da; Wed, 13 Jul 2022 08:29:40 +0200
Date:   Wed, 13 Jul 2022 08:29:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH] USB: serial: io_edgeport: Fix spelling mistake
Message-ID: <Ys5mVIsu8O5Beh9a@hovoldconsulting.com>
References: <20220629064153.23476-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629064153.23476-1-jiaming@nfschina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:41:53PM +0800, Zhang Jiaming wrote:
> Change 'paramater' to 'parameter'.
> Change 'timedout' to 'timeout'.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>

Applied, thanks.

Johan
