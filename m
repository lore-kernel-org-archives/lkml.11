Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB266C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 12:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349299AbiFUMVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349239AbiFUMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:21:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4DA22B3C;
        Tue, 21 Jun 2022 05:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39BB0B817CA;
        Tue, 21 Jun 2022 12:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5112C3411C;
        Tue, 21 Jun 2022 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655814065;
        bh=/QA8rTC0p7GRvvColM1nLcKT5hT8s/bezUqDj7R/BtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z8HXWoKhHyk8drACVu8HCP5pEXWrEi1IpiwgQ4gNqZbpQhB9LUjbL6rjIhM1BdS7S
         K3d+kpedf+gVa2H5ZmrNDXzG+SLQIu4qfm78gScp48sxn+FMwi2z8xQu67D10XWBjW
         HYM5mYS89wmSWzdBc7dSimHncxk5bYO9QH1NHyDg=
Date:   Tue, 21 Jun 2022 14:21:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Yonglin Tan <yonglin.tan@outlook.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: option: add Quectel EM05-G modem
Message-ID: <YrG3rMwMlUH6YEi8@kroah.com>
References: <MEYP282MB2374442EF3E1F4E95B8E311CFDB39@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <YrG08xVVdfjswFVO@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrG08xVVdfjswFVO@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 02:09:23PM +0200, Johan Hovold wrote:
> On Tue, Jun 21, 2022 at 07:59:43PM +0800, Yonglin Tan wrote:
> >  drivers/usb/serial/option.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >  mode change 100644 => 100755 drivers/usb/serial/option.c
> 
> You're still trying to change the permission bits of the file here,
> though.
> 
> You need to figure out why this happens yourself. But I can't accept the
> patch before this is fixed.
> 
> You could try chmod 644 before committing, but that may not be
> sufficient.

This usually happens when working on a FAT filesystem, or on Windows.

