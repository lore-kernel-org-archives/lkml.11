Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B96C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 08:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiCCI03 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 03:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiCCI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:26:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB8512BF75;
        Thu,  3 Mar 2022 00:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F68D61AB0;
        Thu,  3 Mar 2022 08:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695F5C004E1;
        Thu,  3 Mar 2022 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646295942;
        bh=FzERdXwGq+QaSvTfcC68YudjS9FCfSbCOgzAlWuyhWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrABbJcVCNxEWDpgx1+0FfGc2jcnDE5t6g3fdB2u78D7+EGACULaguXdHJYpryeNL
         YcD6z748vVBKVqwHzjdoLc+1mtryQkJIu83lgtsvFL7Mn2Ql8H6/Bb2J3kHskc1Jqf
         0rpRHbrWGV7Ke9LQ42g+NVPDXbvQ2MbB311gD6RqMqgCr/t+jqVkY73REgAfNtpwcl
         wjykcHWZSgLIEbHACXSUSE4ugg9kiDmBn+9rB8Xx0hS78GZnE1y1xuVNCvC8HuzZII
         uND0pFfK+tPNiXQN7Fa6f24GqPdiIZM+uB0weEGR+yzEKrYXEk1R0XxGt+ZqU4U9xq
         dnA4Lgr0CNWrA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPgmJ-0001l7-M2; Thu, 03 Mar 2022 09:25:39 +0100
Date:   Thu, 3 Mar 2022 09:25:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
Message-ID: <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
References: <20220301224446.21236-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301224446.21236-1-eajames@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 04:44:46PM -0600, Eddie James wrote:
> IBM manufactures a PL2303 device for UPS communications. Add the vendor
> and product IDs so that the PL2303 driver binds to the device.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Fix commit message Signed-off-by ordering.

Almost there. You're still missing a Co-developed-by tag, a From line,
or both.

Please take another look at the documentation I pointed to.

Johan
