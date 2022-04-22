Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B6AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 14:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448874AbiDVOsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 10:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380235AbiDVOsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF0E5C34F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A8860E84
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A526C385A9;
        Fri, 22 Apr 2022 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650638758;
        bh=cDxTioHiBNl0ShGtOtJTiJLp7g6rOsr5782kvRAjCUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otANhqrgOZHmla1PLVJTn+/PeBD/i4BRde0GTTPX7VRnhwthPs/KGhRuF8kJSCKYE
         eAehXxRmztorxGkk/oohqzi/Qlv0yNaXqK6nhnE4nIA/qGxpsl+65hipm9jHw0KdI7
         6MQ41ud0P6T2NoQtjVu69UE+FCa5dTyZrooqIids=
Date:   Fri, 22 Apr 2022 16:45:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v4 7/7] staging: r8188eu: remove unused else condition
Message-ID: <YmK/o23YIeXwKlep@kroah.com>
References: <cover.1650568579.git.jhpark1013@gmail.com>
 <bba338ae5f9992dbf2a64b388f7702e6b287d8c2.1650568579.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bba338ae5f9992dbf2a64b388f7702e6b287d8c2.1650568579.git.jhpark1013@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:20:32PM -0400, Jaehee Park wrote:
> s_ret cannot return '2' so this else condition is unused. Remove this
> unnecessary else statement.

s_ret is not a function, it is a value.
rtw_select_and_join_from_scanned_queue() is the function here.

Can you fix up the wording in this changelog text and resubmit?

thanks,

greg k-h
