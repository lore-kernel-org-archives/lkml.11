Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48DCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jan 2022 15:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiAXPLM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jan 2022 10:11:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55316 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbiAXPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:10:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 86877CE1192
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E9FC340E1;
        Mon, 24 Jan 2022 15:10:52 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] arm64: vdso: Fix "no previous prototype" warning
Date:   Mon, 24 Jan 2022 15:10:50 +0000
Message-Id: <164303699846.16509.2701629147557731709.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121121234.47273-1-vincenzo.frascino@arm.com>
References: <20220109113504.1921017-1-mkl@pengutronix.de> <20220121121234.47273-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 12:12:34 +0000, Vincenzo Frascino wrote:
> If compiling the arm64 kernel with W=1 the following warning is produced:
> 
> | arch/arm64/kernel/vdso/vgettimeofday.c:9:5: error: no previous prototype for ‘__kernel_clock_gettime’ [-Werror=missing-prototypes]
> |     9 | int __kernel_clock_gettime(clockid_t clock,
> |       |     ^~~~~~~~~~~~~~~~~~~~~~
> | arch/arm64/kernel/vdso/vgettimeofday.c:15:5: error: no previous prototype for ‘__kernel_gettimeofday’ [-Werror=missing-prototypes]
> |    15 | int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
> |       |     ^~~~~~~~~~~~~~~~~~~~~
> | arch/arm64/kernel/vdso/vgettimeofday.c:21:5: error: no previous prototype for ‘__kernel_clock_getres’ [-Werror=missing-prototypes]
> |    21 | int __kernel_clock_getres(clockid_t clock_id,
> |       |     ^~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: vdso: Fix "no previous prototype" warning
      https://git.kernel.org/arm64/c/58cd4a088e89

-- 
Catalin

