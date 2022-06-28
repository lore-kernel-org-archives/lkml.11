Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3231C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 06:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbiF1Gm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 02:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343594AbiF1Gmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:42:35 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA126AC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656398523; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=cX/cZrKhxSx/PKbMF4/oKQ+jsDcIg5Z6kNJX8n0IDf5eoILUo4XN4qwVIndzTDsDe/JmlvcBbzbeUq2lIKciWoMVctF6QVnZKYcA45zaXN7zkXtYmCT2AjYvbchPth4oXTiNcJEfHnKJ8ijEadwMDgzEBSjX6OIzcg0uP1Da+fI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1656398523; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=pwBhxQsXM2xG4XBvZsefXNn9UjZeDWvvFqvWTEAn2+k=; 
        b=I+7e84CO/imSIuiyvYcjjaMt2PDywcY+V+neYAa0VUtQVy9YCrwoqT5+6GbH3GLmAVKg8yjwZeun44LkDPPvJiWg3TAWIumeSuBWZN3f2b3y9vDkPVTBHDEYVCs7Sg5DBovbFDT4IPl5LST3SHlrW/UIVsJdN8Gkr33Q/JmzFRk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656398523;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=pwBhxQsXM2xG4XBvZsefXNn9UjZeDWvvFqvWTEAn2+k=;
        b=Q2r6U/xxP0t/Br9OPEB6X/3n9JFP7ExaILQIptzBGCJULMyrdV3gageLcCUup81H
        rIbugSNU0xW8BAgSHGj1IffTAjFhYuNaFwBuzb/hCfhwDkI3EDZsuPLCuJjO0tXaHw8
        9QGe2bUB+fRuH0PBZwLRGMxEj1cn8cuFSBQiZrPo=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1656398513098179.83531316121014; Tue, 28 Jun 2022 12:11:53 +0530 (IST)
Date:   Tue, 28 Jun 2022 12:11:53 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Vlad Dronov" <vdronov@redhat.com>,
        "Harald Freudenberger" <freude@linux.ibm.com>
Cc:     "Herbert Xu" <herbert@gondor.apana.org.au>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        "Kernel Mentees List" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <181a90b83b6.ba9fe3d538365.4289053582876165476@siddh.me>
In-Reply-To: <CAMusb+RDvUG9ZmSH0cxqJAXzniDDihsuaWhKu7M8bchatcuUSQ@mail.gmail.com>
References: <20220627075148.140705-1-code@siddh.me> <9f79f8edfa8f7c5099b842f020782ac2@linux.ibm.com> <CAMusb+RDvUG9ZmSH0cxqJAXzniDDihsuaWhKu7M8bchatcuUSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/testing/crypto: Use vzalloc instead of
 vmalloc+memset
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 16:26:12 +0530  Vlad Dronov <vdronov@redhat.com> wrote
 > Thanks, Siddh,
 > 
 > This change makes perfect sense.

On Mon, 27 Jun 2022 15:24:46 +0530  Harald Freudenberger <freude@linux.ibm.com> wrote
 > Thanks Siddh
 > I'll forward this patch into the s390 subsystem and on the next merge
 > window for the 5.20 kernel then it will appear in the upstream kernel.

Thanks Harald, and Vlad.

Apologies for not CC'ng it to the s390 mailing list. The MAINTAINERS file does not
have entry for this file. I will send the patch for it.

Thanks,
Siddh
