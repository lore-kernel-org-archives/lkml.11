Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E28C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 08:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351365AbiBHItl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiBHItj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:49:39 -0500
X-Greylist: delayed 61792 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 00:49:37 PST
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1C2C03FEC3;
        Tue,  8 Feb 2022 00:49:37 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 49D9960008;
        Tue,  8 Feb 2022 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644310176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fd4uFtjJGdfJJRwtaUHWCEU07/RNAAQNRJtK8s2mzd8=;
        b=LfDLqMxR8q5HG5/ou30jf/aMXvkUet5xFv6OvZ4BzwNreZ5GdvRwTq8XIQvLl7SP1VnO14
        ce+iDmDkL2WfUe58kYBv3Z+rvo1n1PeRD4buA2PM7uzSP/xu/C5B2cwCH3mF9JUR4Egsn1
        YtqTikj9mtErK09HoqG2oTph/UUxL/ykzL0iSUzKOepnFixAZHjxZCnBrSbb6Ef1luwcod
        7DQ3/BAcS4ECqGqxhLJTz51vJp9F9a5pzON1DcSrHu/vlfBfCpbPwTEkocq4hXKkbYLbfj
        ZCRQ+xsTYufC8rup445NDq/HtrRZ0gaMO4F6jgZOQJDOfLd5QnK3aaoP/Gx3xA==
Date:   Tue, 8 Feb 2022 09:49:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-mtd@lists.infradead.org
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        stable@vger.kernel.org, sfr@canb.auug.org.au,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: rawnand: protect access to rawnand devices
 while in suspend
Message-ID: <20220208094931.0b4454dc@xps13>
In-Reply-To: <YgIsK+eGr6pqHQhQ@kroah.com>
References: <20220208082507.1837764-1-sean@geanix.com>
        <YgIsK+eGr6pqHQhQ@kroah.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

gregkh@linuxfoundation.org wrote on Tue, 8 Feb 2022 09:39:07 +0100:

> On Tue, Feb 08, 2022 at 09:25:06AM +0100, Sean Nyekjaer wrote:
> > Prevent rawnend access while in a suspended state.

                ^
Just saw the typo here

> > 
> > Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
> > rawnand layer to return errors rather than waiting in a blocking wait.
> > 
> > Tested on a iMX6ULL.
> > 
> > Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
