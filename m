Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD64C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 08:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390209AbiEFIoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 04:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390210AbiEFIny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:43:54 -0400
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 01:40:11 PDT
Received: from mail.systemmarket.com.pl (mail.systemmarket.com.pl [31.14.131.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7C72B1A9
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:40:11 -0700 (PDT)
Received: by mail.systemmarket.com.pl (Postfix, from userid 1001)
        id DC2DEA1CCE; Fri,  6 May 2022 09:27:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=systemmarket.com.pl;
        s=mail; t=1651825826;
        bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=;
        h=Date:From:To:Subject:From;
        b=iARDsQpYU2mxTohXoU+yHEcwA+aBSuFjdUv6DumOFedAi841oQeIZ3WhMHgHDykp6
         ju4VAgMfDH5XOlFDoxjrCP26MyvBCKTL+tDiAZJpNjT6sqvp+w/dea7p0HRpoL1Mp0
         LxSW7JMXQL0AlikRy9996D0MnoKsqMJL8wdVR+yQZegruy9vY2vgZXn6oCOUJbpDOd
         g6QIpc33ftxIxLZtsqLfp1PajDniDOPvyv2RxlrFVVouXYEvm7CTnjr/4Hu28Zg3Ke
         xGXaTnFA38U3LBJ6Uz0L5EBHE6nZpUNsURy9bRb9aGQk8P0fZKt6J27InV7KS/aYVL
         9MGMnBITy63/Q==
Received: by mail.systemmarket.com.pl for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:26:39 GMT
Message-ID: <20220506085610-0.1.19.3kq4.0.0kmpnbpld0@systemmarket.com.pl>
Date:   Fri,  6 May 2022 08:26:39 GMT
From:   =?UTF-8?Q? "Przemys=C5=82aw_Wr=C3=B3blewski" ?= 
        <przemyslaw.wroblewski@systemmarket.com.pl>
To:     <linux-kernel@vger.kernel.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.systemmarket.com.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dzie=C5=84 dobry,

dostrzegam mo=C5=BCliwo=C5=9B=C4=87 wsp=C3=B3=C5=82pracy z Pa=C5=84stwa f=
irm=C4=85.

=C5=9Awiadczymy kompleksow=C4=85 obs=C5=82ug=C4=99 inwestycji w fotowolta=
ik=C4=99, kt=C3=B3ra obni=C5=BCa koszty energii elektrycznej nawet o 90%.

Czy s=C4=85 Pa=C5=84stwo zainteresowani weryfikacj=C4=85 wst=C4=99pnych p=
ropozycji?


Pozdrawiam,
Przemys=C5=82aw Wr=C3=B3blewski
