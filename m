Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56BEC0502A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 12:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiH3MuB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiH3Mt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:49:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C8915A2E;
        Tue, 30 Aug 2022 05:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E594B81B13;
        Tue, 30 Aug 2022 12:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0765C433C1;
        Tue, 30 Aug 2022 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661863795;
        bh=uygw8/1pX9qwg7jJu1Zlgn4AfSH9pfarsnrVapMvZBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ld0BnanAvnrx3OMI+kaBa7VcG9CLMZ2Xb//WD7lWw92em1OhHBbWQwPaqE1ZABG0z
         ID2VFi72BjN2YB6aGD5IPcjd6/a0y3hFohAMmxiEh/rV1LUm2cvq6PejVwiTyFAfPr
         9MeNNgTxp6BzJdDISXXQ+6O+BYEt0/KM+tlLq3Ro=
Date:   Tue, 30 Aug 2022 14:49:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xupanda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next v3] usb: typec: tcpm: tcpci: Remove the
 unneeded result variable
Message-ID: <Yw4HcNoWFuHIem1h@kroah.com>
References: <20220829030442.264695-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829030442.264695-1-xu.panda@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 03:04:43AM +0000, cgel.zte@gmail.com wrote:
> From: xupanda <xu.panda@zte.com.cn>
> 
> Return the value regmap_update_bits() directly instead of
> storing it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

I am now just going to drop all patches like this, given that no one
seems to be following the proper documentation for how to handle
research tools like this :(

greg k-h
