Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C8EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 10:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348132AbiFJK3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 06:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbiFJK3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:29:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1220328710;
        Fri, 10 Jun 2022 03:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CFE961FC6;
        Fri, 10 Jun 2022 10:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3E5C34114;
        Fri, 10 Jun 2022 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654856973;
        bh=UZidtPEvEK77l+e2n9kF+wSCIVTS3cV/LYPi3wf/Oy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjTJFqG7sII+2/NuzhANjQwG1jp7ahxq5ZCWEHaSTjAcuK6FDvnuLgldJelovZJuX
         FUnM2VXX97B+ul7xtvX1V8XzsTcnoOGD80NBzEOl0ODSTphiEDGVc5ehOf232rKnHx
         Gwv3yfNGnqhEFebb2ZU119nq3+BZ32da0xXM4Lho=
Date:   Fri, 10 Jun 2022 12:29:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] usb: typec: Separate USB PD from USB Type-C
Message-ID: <YqMdCr/XHTAsA72l@kroah.com>
References: <20220502132058.86236-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502132058.86236-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 04:20:55PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> The data structures are now named "usb_power_deliver*" and the kobject
> attributes are now device attributes.
> 
> 
> v3 cover letter:
> 
> Now everything is a device. There are now other changes.

Much much nicer, thanks for doing this.  All now applied, let's see how
0-day likes it.

greg k-h
