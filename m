Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1651C3F6B0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 08:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiHLIjf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 04:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbiHLIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:39:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40F3A894B;
        Fri, 12 Aug 2022 01:39:20 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:39:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660293558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdTINvATLF56Uw9LRaJke+LSg13VtOt5R8Nqzh1PUtw=;
        b=W2BkF7c2/ICbq4sbb+oFpLXZaFEM9oqE9NXaY1ot5MkXTjistWnOG3J3RgPt0A8z6fbyOp
        47Tcc1mvCHSddFVDlQe+OgQ6soZY6fIji762xAKKNgIBkdWgiYm7tp/9NfO0W+vhFFoNjR
        4fErLCzCMGHitOe8u76eTLZMJnQYuMTvLh9bwn5N2gD/6kBv0iHbMUEJ/ToG6zJkZEKewf
        HJU224q+9rZf3h1k93V2DciWLmgG6dGL1Xg4aFtaziEN4KAumVSF+tPID5WOicPfIbVI6K
        Q4NcqRqsJ4HPOSYMcJ/uIxkYINlXTitcbTmxMWAL0DD97b7OKeUa4SsIEaaKbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660293558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdTINvATLF56Uw9LRaJke+LSg13VtOt5R8Nqzh1PUtw=;
        b=LRt1dNZspeZC4wmsIL12k1l1Ker4F3wZFV9cKkPg7qt6GsZBB0FRkbcF5PixkxSEyuvZZf
        FeFv0dJaCcRc+TCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Oleg.Karfich@wago.com, Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 25/25] fs/dcache: Disable preemption on
 i_dir_seq write side on PREEMPT_RT
Message-ID: <YvYRtfMsF5tp9k+0@linutronix.de>
References: <20220811160826.1541971-1-sashal@kernel.org>
 <20220811160826.1541971-25-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220811160826.1541971-25-sashal@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-11 12:08:20 [-0400], Sasha Levin wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> [ Upstream commit cf634d540a29018e8d69ab1befb7e08182bc6594 ]

Could please drop that one from the stable series? It does not effect
!PREEMPT_RT / mainline. Linus was not to happy about the ifdef
PREEMPT_RT here. This one is about to be reworked=E2=80=A6

Sebastian
