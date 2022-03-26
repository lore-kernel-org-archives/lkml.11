Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5469C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 21:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiCZVip convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 17:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiCZVim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 17:38:42 -0400
X-Greylist: delayed 136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Mar 2022 14:37:03 PDT
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de [80.67.18.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A121610E1;
        Sat, 26 Mar 2022 14:37:03 -0700 (PDT)
Received: from [80.82.223.85] (helo=mail.piie.net)
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <peter@piie.net>)
        id 1nYE3a-0001fZ-Kq; Sat, 26 Mar 2022 22:34:46 +0100
MIME-Version: 1.0
Date:   Sat, 26 Mar 2022 21:34:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.16.0
From:   "=?utf-8?B?UGV0ZXIgS8Okc3RsZQ==?=" <peter@piie.net>
Message-ID: <74c2ef3d81f12516f508af014027ec46@piie.net>
Subject: Re: [PATCH] platform/x86: acerhdf: Cleanup str_starts_with()
To:     "Wei Li" <liwei391@huawei.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com
In-Reply-To: <20220326020249.3266561-1-liwei391@huawei.com>
References: <20220326020249.3266561-1-liwei391@huawei.com>
X-Df-Sender: cGV0ZXJAcGlpZS5uZXQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26. März 2022 02:53, "Wei Li" <liwei391@huawei.com> schrieb:

> Since there is already a generic function strstarts() that check if a
> string starts with a given prefix, cleanup str_starts_with().
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>

Acked-by: Peter Kästle <peter@piie.net>

[...]
