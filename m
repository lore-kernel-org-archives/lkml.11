Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD31DC25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 10:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiHJKnb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiHJKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC180507;
        Wed, 10 Aug 2022 03:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A2E9B81A71;
        Wed, 10 Aug 2022 10:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5B2C433D6;
        Wed, 10 Aug 2022 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660128180;
        bh=VIHJef5BKW47Clj1CM0k5ScxMQqWvRhyfTpzQ0wyG2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pK2Y48PBsmUK00P3zMdkhQVw2qw0SrdxhdAdbhllc6nxiSR5O99FEL/xORchJ8OqL
         Vl5MamvVbi3Ea21iJxBznalB04/vOBmUzF5g99efCr7sOn0GpDsq1VXPJ9prAundca
         Qo0fY4D+68HeFXj9g09N4p0V8oMF7Iuhftkgiraw=
Date:   Wed, 10 Aug 2022 12:42:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: usbtest: Fix typo in comments
Message-ID: <YvOLsmget0hO9MsT@kroah.com>
References: <20220810103000.8721-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810103000.8721-1-dengshaomin@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 06:30:00AM -0400, shaomin Deng wrote:
> Delete the rebundant word "with" in comments.
> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>

Is your name written on documents as "shaomin Deng" or "Shaomin Deng"?
Please use the correct one if at all possible.

thanks,

greg k-h
