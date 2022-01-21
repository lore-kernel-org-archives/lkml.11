Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C97C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jan 2022 17:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381969AbiAURzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jan 2022 12:55:41 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:43323 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiAURzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:55:40 -0500
Date:   Fri, 21 Jan 2022 17:55:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1642787736;
        bh=h+mshvy4XPQ7rsHduVncvWDnxS0eYZA1azNAEsUFIyM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=ejPGUtK3iE3b3Db34Q3sNBJl+88CQJMcgT/RSyeSv7i/7yT5ERneRPDvnV8ZdvqyF
         O6l0kPi/qzK9CGbIBb/iDBjSWfPQBVRRyEc7RsgNeDGWMdpZ6B0q76TKnFJSKypfAB
         DOcYlsgkuVacVWqtxDrcvmh+oGxXQ4ScjYEHZlzhzbfF1u2nkTEEtW52yYN1O2qMId
         5wp0dj3LYoTBg5DCo9LOj76qK5rNIPEGGu70MlnSOuZP/O4iGVoqh0IpcFEniF0BOH
         8Q2Kkwq+F8VBdfeVijKtH+C1Hd0n34yHZhle0530ec0ZDl63Ysfuwy8qF5nvPhEolu
         ZGIulo6OoDrTQ==
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org,
        =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Reply-To: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Subject: [PATCH v3 0/3] Support for Apple SoCs' NCO blocks
Message-ID: <20220121175441.9944-1-povik+lin@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sending v3 of common clock driver for NCO blocks on recent Apple SoCs.

Changes since v2:

 - move all under applnco_ prefix
 - move away from signed types in register value calculations
 - other minor things from Stephen's review

Changes since v1:

 - drop apple,nchannels property from the binding, rely on size of the regi=
ster
   range instead to gauge the number of channels
 - add a lock to guard set_rate from racing with clock disable/enable
 - add short "theory of operation" comment
 - incorporate minor changes from Rob's, Sven's and Stephen's review (thank=
s!)

Martin

v1: https://lore.kernel.org/linux-clk/20211214120213.15649-1-povik@protonma=
il.com/
v2: https://lore.kernel.org/linux-clk/20220118191839.64086-1-povik+lin@prot=
onmail.com/

Martin Povi=C5=A1er (3):
  dt-bindings: clock: Add Apple NCO
  clk: clk-apple-nco: Add driver for Apple NCO
  MAINTAINERS: Add clk-apple-nco under ARM/APPLE MACHINE

 .../devicetree/bindings/clock/apple,nco.yaml  |  62 ++++
 MAINTAINERS                                   |   2 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-apple-nco.c                   | 333 ++++++++++++++++++
 5 files changed, 407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml
 create mode 100644 drivers/clk/clk-apple-nco.c

--
2.33.0


